//
//  FBDataProvider.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/27/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBDataProvider.h"
#import "FBFile.h"
#import "FBBrand.h"
#import "FBTag.h"
#import "FBMenu.h"
#import "AFNetworking.h"
#import "SSZipArchive.h"
#import "HSupport.h"
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

NSString *xmlURL = @"https://pharm.melodrom.ru/xml";
@interface FBDataProvider () <NSXMLParserDelegate>{
    BOOL nowParseRemoteXML;
    int loadersCounter;
    NSData *remoteXML;

}
@property (nonatomic, strong) NSString* settingFile;
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableArray *filesArray;
@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (nonatomic, strong) NSMutableArray *brandsArray;
@property (nonatomic, strong) NSMutableArray *menuItemsArray;
@property (nonatomic, strong) FBFile *currentFile;
@property (nonatomic, strong) FBTag *currentTag;
@property (nonatomic, strong) FBTag *currentSubTag;
@property (nonatomic, strong) FBBrand *currentBrand;
@property (nonatomic, strong) FBMenu *currentMenu;

@property (nonatomic, assign) BOOL isSettings;
@property (nonatomic, assign) BOOL isMenu;
@property (nonatomic, assign) BOOL isFiles;
@property (nonatomic, assign) BOOL isTag;
@property (nonatomic, assign) BOOL isFile;
@property (nonatomic, assign) BOOL isTags;

@property (nonatomic, assign) BOOL isBrands;
@property (nonatomic, assign) BOOL isFilesTypes;
@property (nonatomic, assign) BOOL isToolSubType;
@property (nonatomic, assign) BOOL isSubtags;
@property (nonatomic, assign) BOOL isSecondSubTags;

@property (nonatomic, assign) NSInteger buttonTag;

@property (nonatomic, strong) NSMutableArray *local_filesArray;
@property (nonatomic, strong) NSMutableArray *local_tagsArray;
@property (nonatomic, strong) NSMutableArray *local_menuItemsArray;
@property (nonatomic, strong) NSMutableArray *remote_filesArray;
@property (nonatomic, strong) NSMutableArray *remote_tagsArray;
@property (nonatomic, strong) NSMutableArray *remote_menuItemsArray;
@property (nonatomic, strong) NSMutableArray *difference_filesArray;


@end

@implementation FBDataProvider
- (id)init{
    self = [super init];
    if (self) {
        //[self initilize];
    }
    return self;
}
- (void)unzipFile:(FBFile *)file{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@.zip",file.fileId];
    if (![def valueForKey:key]) {
        NSString *zipPath = [[NSBundle mainBundle]pathForResource:file.fileName ofType:@"zip" inDirectory:nil];
        NSLog(@"zip path %@",zipPath);
        NSFileManager *filemgr;
        NSArray *dirPaths;
        NSString *docsDir;
        NSString *newDir;
        
        filemgr =[NSFileManager defaultManager];
        
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
        
        newDir = [docsDir stringByAppendingPathComponent:file.fileName];
        
        if ([filemgr createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error: NULL] == NO)
        {
            // Failed to create directory
            NSLog(@"Can not create directory to unzip");
        }
        else{
            [SSZipArchive unzipFileAtPath:zipPath toDestination:newDir];
            NSArray  *yourFolderContents = [[NSFileManager defaultManager]
                                            contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@",newDir] error:nil];
            NSLog(@"Unziped in %@",newDir);
            [def setValue:@YES forKey:key];
            [def synchronize];
        }
    }
    else{
        NSLog(@"Already done");
    }
    
}
- (void)downloadFile:(FBFile*)file{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:file.fileUrl]];
        if (data) {
            NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Files/%@.%@",file.fileName,file.fileType]];
            
            [data writeToFile:path atomically:YES];
            NSLog(@"File saved: %@",path);
            if ([file.fileType isEqualToString:@"zip"]) {

                [self unzipFile:file];
            }
        }
        else{
            NSLog(@"Could not download file (%@) from server",file.fileName);
        }
        
    });
}
- (FBMenu*)getMenuWithName:(NSString*)name{
    FBMenu *retMenu;
    for (FBMenu *menu in _menuItemsArray) {
        if ([menu.menuName isEqualToString:name]) {
            retMenu = menu;
            break;
        }
    }
    return retMenu;
}
- (void)loadDataWithCompletionHandler:(void (^)(NSError *error))handler andHandlerForMenu:(void(^)(NSError *error))menuHandler{
    _handler = handler;
    _menuHandler = menuHandler;
    [self initilize];
}
- (void)initilize{
    NSLog(@"Start parsing");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"xml"];
    NSURL *filePathURL = [NSURL fileURLWithPath:filePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[DOCSFOLDER stringByAppendingString:@"settings.xml"]]) {
        filePathURL = [NSURL fileURLWithPath:[DOCSFOLDER stringByAppendingString:@"settings.xml"]];
    }
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:filePathURL];
    _parser.delegate = self;
    [_parser setShouldProcessNamespaces:YES];
    [_parser setShouldReportNamespacePrefixes:YES];
    [_parser setShouldResolveExternalEntities:YES];
    [_parser parse];
}
#pragma Mark - DataProviders
- (NSMutableArray*)files{
    return _filesArray;
}
- (NSMutableArray*)tags{
    NSMutableArray *array = [NSMutableArray new];
    return array;
}
- (NSMutableArray*)brands{
    NSMutableArray *array = [NSMutableArray new];
    return array;
}
- (NSMutableArray*)menu{
    return _menuItemsArray;
}
#pragma mark - XML Parser
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"Start Parsing setting.xml");
    if (nowParseRemoteXML) {
        _remote_filesArray = [NSMutableArray new];
        _remote_tagsArray = [NSMutableArray new];
        _remote_menuItemsArray = [NSMutableArray new];
        _filesArray = _remote_filesArray;
        _tagsArray = _remote_tagsArray;
        _menuItemsArray = _remote_menuItemsArray;
    }else{
        _local_filesArray = [NSMutableArray new];
        _local_tagsArray = [NSMutableArray new];
        _local_menuItemsArray = [NSMutableArray new];
        _filesArray = _local_filesArray;
        _tagsArray = _local_tagsArray;
        _menuItemsArray = _local_menuItemsArray;
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Finish Parsing setting.xml");
    
    
    NSLog(@"Number of files %ld",(long)[_filesArray count]);
    for (FBFile *file in _filesArray) {
        NSLog(@"File : %@",file.fileName);
    }
    
    NSLog(@"Number of tags %ld",(long)[_tagsArray count]);
    for (FBTag *file in _tagsArray) {
        NSLog(@"Tag : %@",file.tagName);
    }
    
    NSLog(@"Number of menus %ld",(long)[_menuItemsArray count]);
    for (FBMenu *menu in _menuItemsArray) {
        NSLog(@"Menu : %@",menu);
    }
    //После разбора локального xml идем на сервер за актуальным xml
    if (!nowParseRemoteXML) {
        nowParseRemoteXML = YES;
        AFHTTPRequestOperation *requestOp = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:xmlURL]]];
        if (requestOp != nil) {
            requestOp.responseSerializer = [AFXMLParserResponseSerializer serializer];
            [requestOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSXMLParser *responseObject) {
                NSLog(@"Raw XML Data: %@", [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
                remoteXML = operation.responseData;
                [responseObject setDelegate:self];
                [responseObject setShouldProcessNamespaces:YES];
                [responseObject setShouldReportNamespacePrefixes:YES];
                [responseObject setShouldResolveExternalEntities:YES];
                [responseObject parse];
                NSLog(@"");
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error %@",error);
            }];
            [requestOp start];
        }else{
            if (_handler) {
                _handler(nil);
            }
            
        }
    }else{
        [self compareXMLs];
        if (_handler) {
            _handler(nil);
        }
        
    }

    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:kFile]) {
        _currentFile = [FBFile new];
        _currentFile.fileId = [attributeDict valueForKey:kId];
        _currentFile.fileLocalPath = [attributeDict valueForKey:kName];     //hek4ek added
        _currentFile.fileName = [attributeDict valueForKey:kName];
        NSRange nameRane = [_currentFile.fileName rangeOfString:@"/" options:NSBackwardsSearch];
        if (nameRane.length != 0) {
            _currentFile.fileName = [_currentFile.fileName substringFromIndex:nameRane.location+1];
        }
        else{
            nameRane = [_currentFile.fileName rangeOfString:@"\\" options:NSBackwardsSearch];
            if (nameRane.length!=0) {
                _currentFile.fileName = [_currentFile.fileName substringFromIndex:nameRane.location+1];
            }
        }
        NSRange range = [_currentFile.fileName rangeOfString:@"." options:NSBackwardsSearch];
        if (range.length > 0) {
            
            _currentFile.fileTitle = [_currentFile.fileName substringToIndex:range.location];
            
            _currentFile.fileType = [_currentFile.fileName substringFromIndex:range.location+1];
            _currentFile.fileName = _currentFile.fileTitle;
        }
        //[self downloadFile:_currentFile];
        if ([_currentFile.fileType isEqual:@"zip"]) {
            [self unzipFile:_currentFile];
        }
        _currentFile.fileUrl = [attributeDict valueForKey:kUrl];
        _currentFile.fileHref = [attributeDict valueForKey:kHref];
        _currentFile.fileThumbnail  =  [attributeDict valueForKey:kThumnail];
        _isFile = YES;
    }
    if ([qName isEqualToString:kTags]){
        _isTags = YES;
    }
    if ([qName isEqualToString:kTag]) {
        if (_isFile) {
            [_currentFile.fileCategoryTags addObject:[attributeDict valueForKey:kId]];
        }
        else if(_isTags){
            if (!_isTag) {
                if ([[attributeDict valueForKey:kType] isEqualToString:kMenu]) {
                    _currentMenu = [self getMenuWithName:[attributeDict valueForKey:kName]];
                    _isTag = YES;
                }
                
            }
            else{
                if ([[attributeDict valueForKey:kName] isEqualToString:kBrands]) {
                    _isBrands = YES;
                }
                
                else if ([[attributeDict valueForKey:kName] isEqualToString:kFileTypes]) {
                    _isFilesTypes = YES;
                }
                else if([[attributeDict valueForKey:kName] isEqualToString:kFileToolSubType]){
                    _isToolSubType = YES;
                }
                else if (_isBrands){
                    FBTag *tag = [FBTag new];
                    tag.tagName = [attributeDict valueForKey:kName];
                    tag.tagId = [attributeDict valueForKey:kId];
                    if ([[attributeDict valueForKey:kType] isEqualToString:kSubTag] ) {
                        [_currentMenu.subBrands addObject:tag];
                        _isSecondSubTags = YES;
                    }
                    else{
                        _isSubtags = YES;
                        tag.image = [attributeDict valueForKey:kButtonImage];
                        NSRange range = [tag.image rangeOfString:@"/" options:NSBackwardsSearch];
                        if (range.length!=0) {
                            tag.image = [tag.image substringFromIndex:range.location+1];
                        }
                        tag.selImage = [attributeDict valueForKey:kButtonImageSelected];
                        range = [tag.selImage rangeOfString:@"/" options:NSBackwardsSearch];
                        if (range.length!=0) {
                            tag.selImage = [tag.selImage substringFromIndex:range.location+1];
                        }
                        
                        [_currentMenu.brands addObject:tag];
                        tag.tagBId = _buttonTag++;
                    }
                    
                    
                }
                else if (_isFilesTypes){
                    FBTag *tag = [FBTag new];
                    tag.tagName = [attributeDict valueForKey:kName];
                    tag.tagId = [attributeDict valueForKey:kId];
                    if ([[attributeDict valueForKey:kType] isEqualToString:kSubTag] ) {
                        _isSecondSubTags = YES;
                        [_currentMenu.skuTags addObject:tag];
                    }
                    
                    else{
                        tag.tagBId = _buttonTag++;
                        [_currentMenu.tags addObject:tag];
                        
                        _isSubtags = YES;
                    }
                    
                }
                else if(_isToolSubType){
                    FBTag *tag = [FBTag new];
                    tag.tagName = [attributeDict valueForKey:kName];
                    tag.tagId = [attributeDict valueForKey:kId];
                    
                    tag.tagBId = _buttonTag++;
                    [_currentMenu.toolSubType addObject:tag];
                    
                    _isSubtags = YES;
                    
                }
            }
            
        }
        
    }
    if ([qName isEqualToString:kItem]) {
        
        _currentMenu = [FBMenu new];
        _currentMenu.menuName = [attributeDict valueForKey:kName];
        _currentMenu.menuType = [attributeDict valueForKey:kType];
        _currentMenu.menuId =   [attributeDict valueForKey:kId];
        _isMenu = YES;
    }
    //NSLog(@"Start namespace%@",qName);
}
- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([qName isEqualToString:kMenu]) {
        if (_menuHandler) {
            _menuHandler(nil);
        }
    }
    if ([qName isEqualToString:kItem]){
        [_menuItemsArray addObject:_currentMenu];
        _isMenu = NO;
    }
    if ([qName isEqualToString:kFile]) {
        [_filesArray addObject:_currentFile];
        _isFile = NO;
    }
    if ([qName isEqualToString:kTags]) {
        _isTags = NO;
        _isTag = NO;
        
    }
    if ([qName isEqualToString:kTag]) {
        if (_isSecondSubTags) {
            _isSecondSubTags = NO;
        }
        else if (_isSubtags) {
            _isSubtags = NO;
        }
        else{
            if (_isBrands) {
                _isBrands = NO;
            }
            else if(_isFilesTypes){
                _isFilesTypes = NO;
            }
            else if(_isToolSubType){
                _isToolSubType= NO;
            }
            else if(_isTag){
                _isTag = NO;
            }
            
        }
        
    }
    //NSLog(@"%@ value %@",namespaceURI,_currentElement);
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    _currentElement = string;
}

-(void) compareXMLs{
    _difference_filesArray = [[NSMutableArray alloc] init];
    for (FBFile *remote_fbfile in _remote_filesArray) {
        BOOL localFileExist = NO;
        for (FBFile *local_fbfile in _local_filesArray) {
            if ([remote_fbfile.fileId isEqualToString:local_fbfile.fileId]) {
                localFileExist = YES;
                break;
            }
        }
        if (!localFileExist) {
            [_difference_filesArray addObject:remote_fbfile];
        }
    }
    if (_difference_filesArray.count != 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Обновление"
                                                       message: @"Доступно обновление каталога!\nЗагрузить сейчас?"
                                                      delegate: self
                                             cancelButtonTitle:@"Позже"
                                             otherButtonTitles:@"OK",nil];
        
        
        [alert show];
        
    }else{
        _filesArray = _local_filesArray;
        _menuItemsArray = _local_menuItemsArray;
        
    }
}

-(void) syncFiles{
    //for (FBFile* fbfile in _difference_filesArray) {
    loadersCounter = 0;
    [self loadFromURL_];
    //}
    //[HSupport hideLoader];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0){
        [HSupport showLoader];
        [self syncFiles];
        _filesArray = _remote_filesArray;
        _menuItemsArray = _remote_menuItemsArray;
    }
}
- (void) loadFromURL_  {
    FBFile *fbfile = [_difference_filesArray objectAtIndex:loadersCounter];
    NSURL *url = [NSURL URLWithString:[fbfile.fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLCredential *credential = [NSURLCredential
                                   credentialWithUser:@"Admin"
                                   password:@"3huaaJ74vw5wGFnZPxq7"
                                   persistence:NSURLCredentialPersistenceForSession];
    
    AFHTTPRequestOperation *requestOp = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    [requestOp setCredential:credential];
    [requestOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id data) {
        NSLog(@"downloaded");
        //выпиливаем подкаталоги из урла, чтобы потом их создать их в /Documents/
        NSArray *splitPath = [[NSArray alloc] initWithArray:[fbfile.fileLocalPath componentsSeparatedByCharactersInSet:[NSCharacterSet  characterSetWithCharactersInString:@"/"]]];
        NSString *storePath = DOCSFOLDER;
        //создаем каталоги, если есть необходимость
        for (int i=0; i<[splitPath count]-1; i++) {
            storePath = [storePath stringByAppendingString:splitPath[i]];
            BOOL isDir=NO;
            [[NSFileManager defaultManager] fileExistsAtPath:storePath isDirectory:&isDir];
            if (!isDir) {
                NSError *error = nil;
                NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                                 forKey:NSFileProtectionKey];
                [[NSFileManager defaultManager] createDirectoryAtPath:storePath
                                          withIntermediateDirectories:YES
                                                           attributes:attr
                                                                error:&error];
                if (error)
                    [HSupport showError:[NSString stringWithFormat:@"Error creating directory path: %@", [error localizedDescription]]];
            }
        }
        //..и сохряняем загруженный файл
        [data writeToFile:[DOCSFOLDER stringByAppendingString:fbfile.fileName] atomically:YES];
        if (loadersCounter != [_difference_filesArray count]) {
            loadersCounter++;
            [self loadFromURL_];
        }else{
            [remoteXML writeToFile:[DOCSFOLDER stringByAppendingString:@"settings.xml"] atomically:YES];
            NSDictionary *uInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Синхронизация завершена",@"fileName",nil];
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"fileLoaded" object:self userInfo:uInfo];
            [HSupport hideLoader];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@",error);
        if (loadersCounter != [_difference_filesArray count]-1) {
            loadersCounter++;
            [self loadFromURL_];
        }else
            [HSupport hideLoader];
    }
     ];
    [requestOp setDownloadProgressBlock:^ ( NSUInteger bytesRead , long long totalBytesRead , long long totalBytesExpectedToRead ){
        NSLog(@"progress -- %lld", totalBytesRead);
        NSDictionary *uInfo = [NSDictionary dictionaryWithObjectsAndKeys:fbfile.fileName,@"fileName",
                               [NSString stringWithFormat:@"%.1f",(float)totalBytesRead/1024/1024],@"bytesRead",
                               [NSString stringWithFormat:@"%.1f",(float)totalBytesExpectedToRead/1024/1024], @"totalBytesExpectedToRead",
                               [NSString stringWithFormat:@"%.2f",((float)totalBytesRead/(float)totalBytesExpectedToRead)*100], @"percent",
                               [NSString stringWithFormat:@"%d",loadersCounter+1], @"fileByOrder",
                               [NSString stringWithFormat:@"%lu", (unsigned long)_difference_filesArray.count], @"allFilesCount", nil];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"fileLoaded" object:self userInfo:uInfo];
    }];
    [requestOp start];
    
    
}

@end

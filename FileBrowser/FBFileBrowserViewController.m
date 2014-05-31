//
//  FBFileBrowserViewController.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBFileBrowserViewController.h"
#import "FBTileView.h"
#import "Header.h"
#import "FBWebViewController.h"
#import "FBSKUViewController.h"
#import "FBDataProvider.h"
#import "FBMenu.h"
#import "HSupport.h"

#define TileSideMargin  10
#define TileSpacing     10
#define TileHeight      70
#define TileWidh        470



@interface FBFileBrowserViewController ()<FBTileViewDelegate,FBSKUViewControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *files;
@property (nonatomic, strong) NSMutableArray *brands;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *selectedTags;
@property (nonatomic, strong) NSMutableArray *seletedBrands;
@property (nonatomic, strong) NSMutableArray *selectSubToolTags;
@property (nonatomic, strong) NSMutableArray *filesToShow;
@property (nonatomic, assign) BOOL isLibrary;
@property (nonatomic, assign) BOOL isTool;
@property (nonatomic, strong) UIButton *skuButton;
@property (nonatomic, strong) UIPopoverController* popOver;
@property (nonatomic, strong) FBTag *selectedSkuTag;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) FBMenu *currentMenu;
@property (nonatomic, strong) NSMutableArray* fileList;
@property (nonatomic, assign) BOOL isFirstTime;
@property (nonatomic, assign) CGRect catRect;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic, assign) BOOL isFull;
@end

@implementation FBFileBrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)onTapLogout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Выход" message:@"Вы хотите выйти?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [alert show];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)fbTileViewDidTaped:(FBTileView *)tileView{
 FBWebViewController *webView = (FBWebViewController*) [[UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([FBWebViewController class])];
       webView.file = [tileView file];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webView];
    [self presentViewController:nav animated:YES completion:^{
        _contentScrollView.frame = _contentScrollView.frame;
    }];
    //[self.navigationController pushViewController:webView animated:YES];
    //[self presentViewController:webView animated:YES completion:nil];
}
- (void)loadFiles:(NSMutableArray*)files{
    _filesToShow = [NSMutableArray arrayWithArray:files];
    for (UIView *view in _contentScrollView.subviews) {
        [view removeFromSuperview];
    }
    int xPos = 3*TileSideMargin;
    int yPos = TileSideMargin;
    for (int i = 0; i<[_filesToShow count]; i = i+2) {
        
        FBFile *file = [_filesToShow objectAtIndex:i];
        FBTileView *tile = [[FBTileView alloc] initWithFrame:CGRectMake(xPos, yPos, TileWidh, TileHeight) andFile:file];
        tile.delegate = self;
        xPos = (3*TileSideMargin) + TileWidh +(TileSpacing*2);
        [_contentScrollView addSubview:tile];
        
        if (i+1 < [_filesToShow count]) {
            FBFile *file2 = [_filesToShow objectAtIndex:i+1];
            FBTileView *tile2 = [[FBTileView alloc] initWithFrame:CGRectMake(xPos, yPos, TileWidh, TileHeight) andFile:file2];
            [_contentScrollView addSubview:tile2];
            tile2.delegate = self;
            xPos = 3*TileSideMargin;
            yPos = yPos+TileSpacing+TileHeight;
        }
        else{
            yPos =yPos+TileSpacing+TileHeight;
        }
        
        
    }
    _contentScrollView.contentSize= CGSizeMake(_contentScrollView.frame.size.width, yPos);
    
}
- (void)loadFilesData{
    int xPos = TileSideMargin;
    int yPos = TileSideMargin;
    for (int i = 0; i<[_files count]; i = i+2) {
        xPos = TileSideMargin;
        FBFile *file = [_files objectAtIndex:i];
        FBTileView *tile = [[FBTileView alloc] initWithFrame:CGRectMake(xPos, yPos, TileWidh, TileHeight) andFile:file];
        tile.delegate = self;
        xPos = 3*TileSideMargin + TileWidh +(TileSpacing*2);
        [_contentScrollView addSubview:tile];
        
        if (i+1 < [_files count]) {
            FBFile *file2 = [_files objectAtIndex:i+1];
            FBTileView *tile2 = [[FBTileView alloc] initWithFrame:CGRectMake(xPos, yPos, TileWidh, TileHeight) andFile:file2];
            [_contentScrollView addSubview:tile2];
            tile2.delegate = self;
            xPos = TileSideMargin;
            yPos = yPos+TileSpacing+TileHeight;
        }
        else{
            yPos =yPos+TileSpacing+TileHeight;
        }
        
    }
    _contentScrollView.contentSize= CGSizeMake(_contentScrollView.frame.size.width, yPos);
}
- (NSMutableArray*)filterFiles:(NSMutableArray*)files byTags:(NSMutableArray*)tags{
    if ([tags count] == 0) {
        return [NSMutableArray arrayWithArray:files];
    }
    NSMutableArray *filterFiles = [NSMutableArray new];
    for (FBFile *file in files) {
        for (NSString *tagId in file.fileCategoryTags) {
            for (FBTag *tag in tags) {
                if ([tagId isEqualToString:tag.tagId]) {
                    [filterFiles addObject:file];
                }
            }
        }
    }
    return filterFiles;
}
- (void)filerFilesByBrandsAndTags{
    [_filesToShow removeAllObjects];
   
    NSMutableArray *filterByBrand = [NSMutableArray new];
    
    /*if ([_seletedBrands count] == 0) {
        filterByBrand= _files;
    }
    else{
        for (FBFile *file in _files) {
            
            for (NSString *tagid in file.fileCategoryTags) {
                for (FBTag *tag in _seletedBrands) {
                    if ([tagid isEqualToString:tag.tagId] ) {
                        if (![filterByBrand containsObject:file]) {
                            [filterByBrand addObject:file];
                            break;
                        }
                    }
                }
            }
            
        }
    }
    
    NSMutableArray *filterByTag = [NSMutableArray new];
    if ([_selectedTags count] == 0) {
        filterByTag = filterByBrand;
    }
    else{
        for (FBFile *file in filterByBrand) {
            for (NSString *tagid in file.fileCategoryTags) {
                for (FBTag *tag in _selectedTags) {
                    if ([tagid isEqualToString:tag.tagId] ) {
                        if (![filterByTag containsObject:file]) {
                            [filterByTag addObject:file];
                            break;
                        }
                    }
                }
            }
            
        }
    }
    NSMutableArray *filesAfterToolFilter ;
    if ([_selectSubToolTags count] > 0) {
        filesAfterToolFilter = [NSMutableArray new];
        for (FBFile *file in filterByTag) {
            for (FBTag *tg in _selectSubToolTags) {
                for (NSString *tid in file.fileCategoryTags) {
                    if ([tid isEqualToString:tg.tagId]) {
                        if (![filesAfterToolFilter containsObject:file]) {
                            [filesAfterToolFilter addObject:file];
                            break;
                        }
                    }
                }
            }
        }
    }
    else{
        filesAfterToolFilter = filterByTag;
    }
    */
    NSMutableArray *filesFilterWithBrand = [self filterFiles:_files byTags:_seletedBrands];
    NSMutableArray *filterFilesByTags = [self filterFiles:filesFilterWithBrand byTags:_selectedTags];
    NSMutableArray *filesAfterToolFilter = [self filterFiles:filterFilesByTags byTags:_selectSubToolTags];
    
    if (self.selectedSkuTag) {
        for (FBFile *file in filesAfterToolFilter) {
            for (NSString *tagid in file.fileCategoryTags) {
                if ([tagid isEqualToString:_selectedSkuTag.tagId]) {
                    [_filesToShow addObject:file];
                    break;
                }
            }
            
        }
    }
    else {
        _filesToShow = filesAfterToolFilter;
    }
    
    [self loadFiles:_filesToShow];
}
- (void)onTapBrands:(id)sender{
    UIButton *b = (UIButton*)sender;
    if (b.selected) {
        for (FBTag *brand in _seletedBrands) {
            if(brand.tagBId == b.tag){
                [_seletedBrands removeObject:brand];
                break;
            }
        }
        if (isIOS6) {
            b.backgroundColor = [UIColor clearColor];
        }
        b.selected = NO;
    }
    else{
        b.selected = YES;
        for (FBTag *brand in _brands) {
            if (brand.tagBId == b.tag) {
                [_seletedBrands addObject:brand];
                break;
            }
        }
        if (isIOS6) {
            b.backgroundColor = [UIColor whiteColor];
        }
    }
    [self filerFilesByBrandsAndTags];
}
- (void)onTapTagsButton:(id)sender{
    UIButton *b = (UIButton*)sender;
    if (b.selected) {
        for (int i =0; i<[_selectedTags count]; i++) {
            FBTag *tag = [_selectedTags objectAtIndex:i];
            if (tag.tagBId == b.tag) {
                [_selectedTags removeObject:tag];
                break;
            }
        }
        if (isIOS6) {
            b.backgroundColor = [UIColor clearColor];
        }
        
        b.selected = NO;
    }
    else{
        for (FBTag *tag in _tags) {
            if (tag.tagBId == b.tag) {
                [_selectedTags addObject:tag];
                break;
            }
        }
        if (isIOS6) {
            b.backgroundColor = [UIColor whiteColor];
        }
        b.selected = YES;
    }
    [self filerFilesByBrandsAndTags];
}
-(void)onTapToolTagsButton:(id)sender{
    UIButton *b = (UIButton*)sender;
    if (b.selected) {
        for (int i = 0; i<[_selectSubToolTags count]; i++) {
            FBTag *tag = [_selectSubToolTags objectAtIndex:i];
            if (tag.tagBId == b.tag) {
                [_selectSubToolTags removeObject:tag];
                break;
            }
        }
        
        if (isIOS6) {
            b.backgroundColor = [UIColor clearColor];
        }
        
        b.selected = NO;
    }
    else{
        for (FBTag *tag in _currentMenu.toolSubType) {
            if (tag.tagBId == b.tag) {
                [_selectSubToolTags addObject:tag];
                break;
            }
        }
        if (isIOS6) {
            b.backgroundColor = [UIColor whiteColor];
        }
        b.selected = YES;
    }
    [self filerFilesByBrandsAndTags];
}
- (void)loadTagsAndBrandsData{
    for (UIView *v in _categoriesScrollView.subviews) {
        [v removeFromSuperview];
    }
    //CGRect frame = _categoriesScrollView.frame;
    //frame.size.height = 128;
    //_categoriesScrollView.frame = frame;
    _selectedTags = [NSMutableArray new];
    _seletedBrands = [NSMutableArray new];
    _brands = [NSMutableArray new];
    _brands = [_currentMenu brands];
    
    //NSMutableSet *set = [NSMutableSet setWithArray:_currentMenu.tags];
    //[set addObjectsFromArray:_currentMenu.];
    //[set addObjectsFromArray:_currentMenu.subBrands];
    //[set addObjectsFromArray:_currentMenu.skuTags];
    
    _tags = _currentMenu.tags;//[NSMutableArray arrayWithArray:[set allObjects]];
    

    int xPos = 10;
    int yPos = TileSideMargin;
    int count = 0;
    
    for (int i = 0; i<[_brands count];i++) {
        FBTag *brand = [_brands objectAtIndex:i];
        if([brand.tagName length] >20){
            brand.tagName = [brand.tagName substringToIndex:19];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor =[UIColor clearColor];
        CGFloat width;
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];//[UIFont fontWithName:@"DINPro-Medium" size:14.0];
        if ([brand.image length] > 0) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",brand.image]];
            if (image==nil) {
                [button setTitle:brand.tagName forState:UIControlStateNormal];
                if ([brand.tagName length] > 8) {
                    [button setTitle:[brand.tagName substringToIndex:7] forState:UIControlStateNormal];
                }
                button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [button setBackgroundImage:[UIImage imageNamed:@" button_menu_green.png"] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"button_menu_grey.png"] forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
            }
            else{
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",brand.image]] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",brand.selImage]] forState:UIControlStateSelected];
                [button setTintColor:[UIColor clearColor]];
            //[button setTitle:brand.tagName forState:UIControlStateNormal];
            }
        }
        else{
            [button setTitle:brand.tagName forState:UIControlStateNormal];
            if ([brand.tagName length] > 10) {
                [button setTitle:[brand.tagName substringToIndex:7] forState:UIControlStateNormal];
            }
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [button setBackgroundImage:[UIImage imageNamed:@"button_menu_green.png"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"button_menu_grey.png"] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
            //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            //[button addSubview:titleLabel];
        }
        //xPos = 0;
        width = 86;
        button.frame = CGRectMake(xPos, yPos, width, 44);
        
        button.tag = brand.tagBId;
        
        
        [button addTarget:self action:@selector(onTapBrands:) forControlEvents:UIControlEventTouchUpInside];
        [_categoriesScrollView addSubview:button];
        
        xPos = xPos + (TileSpacing/2) + width;
        
        count++;
        if (xPos >= _categoriesScrollView.frame.size.width-86-(TileSideMargin)) {
            xPos = TileSideMargin;
            yPos = yPos+TileSpacing+44;
            count = 0;
        }
        else if (i==_brands.count-1){
            xPos = TileSideMargin;
            yPos = yPos+TileSpacing+44;
        }
    }
    
    
    if ([_brands count] > 0) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, yPos- (TileSpacing/2), _categoriesScrollView.frame.size.width, 1.0);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        [_categoriesScrollView.layer addSublayer:layer];
    }
    
    xPos = 0;
    for (int i =0; i<[_tags count];i++) {
        FBTag *tag = [_tags objectAtIndex:i];
//        if([tag.tagName length] >25){
//            //tag.tagName = [tag.tagName substringToIndex:24];
//        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        //button.backgroundColor =[UIColor clearColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGFloat width;
        
        [button setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"Button_blue.png"] forState:UIControlStateSelected];
        width = 200;
        button.frame = CGRectMake(xPos, yPos, width, 44);
        [button setTitle:tag.tagName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTintColor:[UIColor clearColor]];
        button.tag = tag.tagBId;
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];//[UIFont fontWithName:@"DINPro-Medium" size:14.0];
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.textAlignment= NSTextAlignmentCenter;
        [button addTarget:self action:@selector(onTapTagsButton:) forControlEvents:UIControlEventTouchUpInside];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_categoriesScrollView addSubview:button];
        
        xPos = xPos + (TileSpacing/2) + width;
        
        count++;
        if (xPos >= _categoriesScrollView.frame.size.width-170-(TileSideMargin)) {
            xPos = 0;
            yPos = yPos+TileSpacing+44;
            count = 0;
        }
        else if(i==_tags.count-1){
            yPos+=TileSpacing+44;
        }
    }
    
   
    if (_isTool) {
        //yPos+=44;
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, yPos-(TileSpacing/2), _categoriesScrollView.frame.size.width, 1.0);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        xPos = 0;
        [_categoriesScrollView.layer addSublayer:layer];
        for (int i =0; i<[_currentMenu.toolSubType count];i++) {
            FBTag *tag = [_currentMenu.toolSubType objectAtIndex:i];
            if([tag.tagName length] >20){
                tag.tagName = [tag.tagName substringToIndex:19];
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            //button.backgroundColor =[UIColor clearColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            CGFloat width;
            
            [button setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"Button_blue.png"] forState:UIControlStateSelected];
            width = 200;
            button.frame = CGRectMake(xPos, yPos, width, 44);
            [button setTitle:tag.tagName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTintColor:[UIColor clearColor]];
            button.tag = tag.tagBId;
            button.titleLabel.font = [UIFont systemFontOfSize:13];////[UIFont fontWithName:@"DINPro-Medium" size:14.0];
            
            [button addTarget:self action:@selector(onTapToolTagsButton:) forControlEvents:UIControlEventTouchUpInside];
            [_categoriesScrollView addSubview:button];
            
            xPos = xPos + TileSpacing + width;
            
            count++;
            if (xPos >= _categoriesScrollView.frame.size.width-190-(TileSideMargin)) {
                xPos = 0;
                yPos = yPos+(TileSpacing/2)+44;
                count = 0;
            }
            else if(i == [_currentMenu.toolSubType count]-1){
                xPos = 0;
                yPos = yPos+TileSpacing+44;
            }
        }
        _isTool = NO;
    }
    if (_isLibrary) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor clearColor];
        CGFloat width = 180;
        button.titleLabel.font = [UIFont systemFontOfSize:13];//[UIFont fontWithName:@"DINPro-Medium" size:14.0];
        xPos = 0;
        //yPos+=44+TileSpacing;
        button.frame = CGRectMake(xPos, yPos, width, 44);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"SKU" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"Button_blue.png"] forState:UIControlStateSelected];
        
        [button setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTintColor:[UIColor clearColor]];
        
        [button addTarget:self action:@selector(onTapSkuButton:) forControlEvents:UIControlEventTouchUpInside];
        _skuButton = button;
        [_categoriesScrollView addSubview:button];
        
        _isLibrary = NO;
        yPos +=44;
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, button.frame.origin.y-(TileSpacing/2), _categoriesScrollView.frame.size.width, 1.0);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        [_categoriesScrollView.layer addSublayer:layer];
        
    }
    CGFloat hegiht ;
    if (yPos >= 400) {
        hegiht = 400;
    }
//    else if (yPos <128){
//        hegiht = 128;
//    }
    else{
        hegiht = yPos;
    }
    //hegiht = 400;
    CGRect frame = CGRectMake(0, 102, 1024, hegiht);
    _categoriesScrollView.frame = frame;
    _contentScrollView.frame = CGRectMake(0, 102+hegiht+TileSpacing, 1024, 724-(102+hegiht+TileSpacing));
    
}
- (void)skuViewController:(FBSKUViewController *)viewController didSelectSku:(FBTag *)skuTag{
    _selectedSkuTag = skuTag;
    if (!skuTag) {
        [_skuButton setTitle:@"SKU" forState:UIControlStateNormal];
        _skuButton.frame = CGRectMake(_skuButton.frame.origin.x, _skuButton.frame.origin.y  , 180, 44);
    }
    else{
        NSString *title = [NSString stringWithFormat:@"SKU: %@",skuTag.tagName];
        [_skuButton setTitle:title forState:UIControlStateNormal];
        CGFloat width = 180;
        if (isIOS6) {
            width = [skuTag.tagName sizeWithFont:[UIFont systemFontOfSize:22]
                               constrainedToSize:_categoriesScrollView.frame.size
                                   lineBreakMode:_skuButton.titleLabel.lineBreakMode].width;
            //button.backgroundColor = [UIColor clearColor];
        }
        else{
            width = [skuTag.tagName sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:22]}].width;
        }
        
        _skuButton.frame = CGRectMake(_skuButton.frame.origin.x, _skuButton.frame.origin.y  , width, 44);
    }
    
    [_popOver dismissPopoverAnimated:YES];
    [self filerFilesByBrandsAndTags];
}
- (void)onTapSkuButton:(id)sender{
    FBSKUViewController *sku = [[FBSKUViewController alloc] initWithFrame:CGRectMake(0, 0, 1024, 320)];
    sku.skuTags = _currentMenu.subBrands;
    sku.delegate = self;
    
    CGRect frame = [sender bounds];
    frame.origin.x = 10;
    _popOver = [[UIPopoverController alloc] initWithContentViewController:sku];
    _popOver.popoverContentSize = CGSizeMake(1024, 320);
    [_popOver presentPopoverFromRect:frame inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (FBMenu*)menuForName:(NSString*)name{
    for (FBMenu *menu in _menuArray) {
        if ([menu.menuName isEqualToString:name]) {
            return menu;
        }
    }
    return nil;
}
- (NSMutableArray*)filesForMenu:(NSString*)menuId{
    NSMutableArray *fList = [NSMutableArray new];
    for (FBFile *f in _fileList) {
        for (NSString *tagid in f.fileCategoryTags) {
            NSLog(@"File Tag new%@",tagid);
            if ([tagid isEqualToString:menuId]) {
                
                if (![fList containsObject:f]) {
                    [fList addObject:f];
                }
            }
        }
    }
    return fList;
}
void runOnMainThread(void (^block)(void))
{
    if (!block) return;
    
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateStatusString:) name:@"fileLoaded" object:nil];

    self.isFirstTime = YES;
    if (isIOS6) {
        [self.statusBarTitle setTintColor:[UIColor clearColor]];
    }
    self.messageLabel.layer.cornerRadius = 5;
    self.messageLabel.layer.masksToBounds = YES;
    _categoriesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 102, 1024, 128)];
    _categoriesScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_categoriesScrollView];
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 238, 1024, 496)];
    _contentScrollView.backgroundColor = [UIColor colorWithRed:255.0/255/0 green:255/255 blue:255/255 alpha:0.36];
    [self.view addSubview:_contentScrollView];
    [self hideScrollViews];
    
    // Do any additional setup after loading the view.
    //[self loadFiles];rgb(1,74,127)
    self.userNameLabel.text = _userName;
    self.userNameLabel.font = [UIFont systemFontOfSize:16.0];//[UIFont fontWithName:@"DINPro-Medium" size:16.0];
    self.messageLabel.font = [UIFont systemFontOfSize:40.0];//[UIFont fontWithName:@"DINPro-Medium" size:40.0];
    self.messageLabel.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    self.messageLabel.backgroundColor = [UIColor colorWithRed:255.0/255/0 green:255/255 blue:255/255 alpha:0.36];
    self.view.backgroundColor =[UIColor colorWithRed:1/255.0 green:74/255.0 blue:127/255.0 alpha:1];
    //[self.detailingButton setSelected:YES];
    //_selectedButton = self.detailingButton;
    UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actInd.hidesWhenStopped = YES;
    _files = [NSMutableArray new];
    _brands = [NSMutableArray new];
    _tags = [FBTag getDetailingTags];//[NSMutableArray new];
    _filesToShow = [NSMutableArray new];
    _selectedTags = [NSMutableArray new];
    _seletedBrands = [NSMutableArray new];
    
    
    [actInd startAnimating];
    [self.view addSubview:actInd];
    actInd.center = self.messageLabel.center;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 102, _categoriesScrollView.frame.size.width, 1.0);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FBDataProvider *dataProvider = [FBDataProvider new];
     
        [dataProvider loadDataWithCompletionHandler:^(NSError *error) {
            _isFull = YES;
            
            weakSelf.fileList = [dataProvider files];
            
            //weakSelf.files = [FBFile getDetailingFiles];
            
            
            weakSelf.currentMenu = weakSelf.menuArray[0];//[weakSelf menuForName:@"Detailing"];
            weakSelf.files = [weakSelf filesForMenu:weakSelf.currentMenu.menuId];
            runOnMainThread(^{
                [actInd stopAnimating];
                //[self loadFiles:_files];
                //[self loadTagsAndBrandsData];
               
            });
        } andHandlerForMenu:^(NSError *error) {
            runOnMainThread(^{
                weakSelf.menuArray = [dataProvider menu];
                for (int i =0; i<[self.menuArray count]; i++) {
                    FBMenu *menu = [self.menuArray objectAtIndex:i];
                    if (menu) {
                        UIButton *button;
                        switch (i) {
                            case 0:{
                                button = self.detailingButton;
                            }
                                
                                //[self.detailingButton setTitle:menu.menuName forState:UIControlStateNormal];
                                break;
                            case 1:
                            {
                                button = self.libraryButton;
                            }
                                break;
                            case 2:
                            {
                                button = self.toolButton;
                            }
                                break;
                            case 3:
                            {
                                button = self.educationalButton;
                            }
                                break;
                            case 4:
                                button = self.myPageButton;
                                break;
                            case 5:
                                button = self.questionierButton;
                                break;
                            case 6:
                                button = self.liveChatButton;
                                break;
                            default:
                                break;
                        }
                        UILabel *titleLabel =
                        [[UILabel alloc] initWithFrame:CGRectMake(2, 0, button.frame.size.width-8, button.frame.size.height)];
                        titleLabel.font = [UIFont boldSystemFontOfSize:12];//[UIFont fontWithName:@"DINPro-Medium" size:14.0];
                        titleLabel.backgroundColor = [UIColor clearColor];
                        titleLabel.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
                        titleLabel.text = menu.menuName;
                        titleLabel.textAlignment = NSTextAlignmentCenter;
                        titleLabel.numberOfLines = 2;
                        
                        [button addSubview:titleLabel];
                        
                    }
                }
            });
            
        }];
        
        
    });

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)selectButton:(UIButton*)button{
    [self.selectedButton setSelected:NO];
    for (UIView *label in self.selectedButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            [((UILabel*)label) setTextColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1]];
        }
    }
    for (UIView *label in button.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            [((UILabel*)label) setTextColor:[UIColor whiteColor]];
        }
    }
    [button setSelected:YES];
    self.selectedButton = button;
}
- (void)showScrollViews{
    self.categoriesScrollView.hidden = NO;
    self.contentScrollView.hidden = NO;
    self.messageLabel.hidden = YES;
}
- (void)hideScrollViews{
    self.categoriesScrollView.hidden = YES;
    self.contentScrollView.hidden = YES;
    self.messageLabel.hidden = NO;
}
- (IBAction)onTapDetailingButton:(id)sender {
    if (!_isFull) {
        return;
    }
    UIButton *button = (UIButton*)sender;
    if (_selectedButton == button) {
        return;
    }
    [self showScrollViews];
    [self selectButton:self.detailingButton];
    _selectedSkuTag = nil;
    _tags = [FBTag getDetailingTags];
    //_files = [FBFile getDetailingFiles];
    _currentMenu = _menuArray[button.tag];//[self menuForName:@"Detailing"];
    self.files = [self filesForMenu:self.currentMenu.menuId];
    [self loadFiles:_files];
    [self loadTagsAndBrandsData];
}

- (IBAction)libraryButton:(id)sender {
    if (!_isFull) {
        return;
    }
    UIButton *button = (UIButton*)sender;
    if (_selectedButton == button) {
        return;
    }
    [self showScrollViews];
    _isLibrary = YES;
    _selectedSkuTag = nil;
    [self selectButton:self.libraryButton];
    //_files =[FBFile getLibraryFiles];
    
    _tags = [FBTag getLibraryTags];
    _currentMenu = _menuArray[button.tag];//[self menuForName:@"Library"];
    self.files = [self filesForMenu:self.currentMenu.menuId];
    [self loadFiles:_files];
    [self loadTagsAndBrandsData];
}

- (IBAction)onTapToolButton:(id)sender {
    if (!_isFull) {
        return;
    }
    UIButton *button = (UIButton*)sender;
    if (_selectedButton == button) {
        return;
    }
    _isTool = YES;
    _selectSubToolTags = [NSMutableArray new];
    [self showScrollViews];
    [self selectButton:self.toolButton];
    _selectedSkuTag = nil;
    _files =[FBFile getToolFiles];
    _tags = [FBTag getToolsTags];
    _currentMenu = _menuArray[button.tag];//[self menuForName:@"Tools"];
    self.files = [self filesForMenu:self.currentMenu.menuId];
    [self loadFiles:_files];
    [self loadTagsAndBrandsData];
}

- (IBAction)onTapEducationalButton:(id)sender {
    if (!_isFull) {
        return;
    }
    UIButton *button = (UIButton*)sender;
    if (_selectedButton == button) {
        return;
    }
    [self showScrollViews];
    [self selectButton:self.educationalButton];
    _selectedSkuTag = nil;
    _files =[FBFile getEducationalFiles];
    _tags = [FBTag getEducationaTags];
    _currentMenu = _menuArray[button.tag];//[self menuForName:@"Educational"];
    self.files = [self filesForMenu:self.currentMenu.menuId];
    [self loadFiles:_files];
    [self loadTagsAndBrandsData];
}

- (IBAction)onTapMyPage:(id)sender {
    if (!_isFull) {
        return;
    }
    UIButton *button = (UIButton*)sender;
    if (_selectedButton == button) {
        return;
    }
    [self showScrollViews];
    [self selectButton:self.myPageButton];
    _selectedSkuTag = nil;
    //_files =[FBFile getMyPageFiles];
   // _tags = [FBTag getMyPageTags];
    _currentMenu = _menuArray[button.tag];//[self menuForName:@"My Page"];
    self.files = [self filesForMenu:self.currentMenu.menuId];
    [self loadFiles:_files];
    [self loadTagsAndBrandsData];
}

- (IBAction)onTapQuestionierButton:(id)sender {
    /*UIButton *button = (UIButton*)sender;
     if (_selectedButton == button) {
     return;
     }
     [self selectButton:self.questionierButton];
     _selectedSkuTag = nil;
     _files =[FBFile getQuestionnaierFiles];
     _tags = [NSMutableArray new];
     [self loadFiles:_files];
     [self loadTagsAndBrandsData];*/
    
    
    //_tags = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Анкетирование";
    file1.fileName = @"ques1";
    file1.fileType = @"html";
    FBWebViewController *webView = (FBWebViewController*) [[UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([FBWebViewController class])];
    webView.file = file1;
    webView.userName = _userName;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webView];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)onTapLiveChatButton:(id)sender {
    /*UIButton *button = (UIButton*)sender;
     if (_selectedButton == button) {
     return;
     }
     [self selectButton:self.liveChatButton];
     _selectedSkuTag = nil;
     _files =[FBFile getLiveChatFiles];
     [self loadFiles:_files];
     [self loadTagsAndBrandsData];*/
    _tags = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Чат";
    file1.fileName = @"live1";
    file1.fileType = @"html";
    FBWebViewController *webView = (FBWebViewController*) [[UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([FBWebViewController class])];
    webView.file = file1;
    webView.userName = _userName;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webView];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void) filesSync{
    for (FBFile *fbfile in self.fileList) {
        [HSupport showLoader];
    }
}
//hek4ek added
-(void)updateStatusString:(NSNotification*)info{
    NSString *status = [[info userInfo] objectForKey:@"fileName"];
    if ([status isEqualToString:@"Синхронизация завершена"]) {
        _statusBarTitle.title = status;
    }else{
        NSString *fileByOrder = [[info userInfo] objectForKey:@"fileByOrder"];
        NSString *allFilesCount = [[info userInfo] objectForKey:@"allFilesCount"];
        NSString *bytesRead = [[info userInfo] objectForKey:@"bytesRead"];
        NSString *totalBytesExpectedToRead = [[info userInfo] objectForKey:@"totalBytesExpectedToRead"];
        NSString *percent = [[info userInfo] objectForKey:@"percent"];
        _statusBarTitle.title = [NSString stringWithFormat:@"%@ из %@: %@ -- %@/%@ Мб (%@%%)",fileByOrder, allFilesCount, status,bytesRead,totalBytesExpectedToRead,percent];
    }
}

@end

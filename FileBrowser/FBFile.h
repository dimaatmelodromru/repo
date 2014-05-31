//
//  FBFile.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBTag.h"

@interface FBFile : NSObject

@property (nonatomic, strong) NSString *fileId;
@property (nonatomic, strong) NSString *fileTitle;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *fileLocalPath;
@property (nonatomic, strong) NSString *fileUrl;
@property (nonatomic, strong) NSString *fileHref;
@property (nonatomic, strong) NSString *fileType;
@property (nonatomic, strong) NSString *fileThumbnail;
@property (nonatomic, strong) NSString *fileCategory;
@property (nonatomic, strong) NSMutableArray *fileBrands;
@property (nonatomic, strong) NSMutableArray *fileCategoryTags;
@property (nonatomic, strong) FBTag *skuTag;

+ (NSMutableArray*)getDetailingFiles;
+ (NSMutableArray*)getLibraryFiles;
+ (NSMutableArray*)getToolFiles;
+ (NSMutableArray*)getEducationalFiles;
+ (NSMutableArray*)getMyPageFiles;
+ (NSMutableArray*)getQuestionnaierFiles;
+ (NSMutableArray*)getLiveChatFiles;
@end

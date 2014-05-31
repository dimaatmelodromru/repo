//
//  FBTag.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBTag : NSObject
@property (nonatomic, strong) NSString *tagId;
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, assign) NSInteger tagBId;
@property (nonatomic, strong) NSString *tagType;
@property (nonatomic, strong) NSMutableArray *subTags;
@property (nonatomic, strong) NSMutableArray *toolSubtags;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *selImage;

+ (NSMutableArray*)getTags;
+ (NSMutableArray*)getSkuTag;
+ (NSMutableArray*)getLibraryTags;
+ (NSMutableArray*)getMyPageTags;
+ (NSMutableArray*)getToolsTags;
+ (NSMutableArray*)getEducationaTags;
+ (NSMutableArray*)getDetailingTags;
@end

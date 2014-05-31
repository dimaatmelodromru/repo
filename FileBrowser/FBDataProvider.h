//
//  FBDataProvider.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/27/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kItem                   @"item"
#define kMenu                   @"menu"
#define kFiles                  @"files"
#define kFile                   @"file"
#define kName                   @"name"
#define kTag                    @"tag"
#define kId                     @"id"
#define kUrl                    @"url"
#define kTags                   @"tags"
#define kType                   @"type"
#define kHref                   @"href"
#define kThumnail               @"thumbnail"
#define kGroup                  @"group"
#define kBrands                 @"Brands"
#define kFileTypes              @"doctypes"
#define kFileToolSubType        @"toolsubtype"
#define kSubTag                 @"subtag"
#define kButtonImage            @"button"
#define kButtonImageSelected    @"button_push"

@interface FBDataProvider : NSObject

@property (nonatomic, strong) void(^handler)(NSError *error);
@property (nonatomic, strong) void(^menuHandler)(NSError *error);

- (NSMutableArray*)files;
- (NSMutableArray*)tags;
- (NSMutableArray*)brands;
- (NSMutableArray*)menu;
- (void)loadDataWithCompletionHandler:(void (^)(NSError *error))handler andHandlerForMenu:(void(^)(NSError *error))menuHandler;

@end

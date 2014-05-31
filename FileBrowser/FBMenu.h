//
//  FBMenu.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/27/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBMenu : NSObject
@property (nonatomic, strong) NSString *menuName;
@property (nonatomic, strong) NSString *menuType;
@property (nonatomic, strong) NSString* menuId;
@property (nonatomic, strong) NSMutableArray *brands;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *subBrands;
@property (nonatomic, strong) NSMutableArray *skuTags;
@property (nonatomic, strong) NSMutableArray *toolSubType;
@end

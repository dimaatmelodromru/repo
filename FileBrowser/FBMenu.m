//
//  FBMenu.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/27/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBMenu.h"

@implementation FBMenu
- (instancetype)init{
    self = [super init];
    if (self) {
        _brands = [NSMutableArray new];
        _skuTags = [NSMutableArray new];
        _tags = [NSMutableArray new];
        _subBrands = [NSMutableArray new];
        _toolSubType = [NSMutableArray new];
    }
    return self;
}
@end

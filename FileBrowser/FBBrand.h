//
//  FBBrand.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBBrand : NSObject
@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, assign) NSInteger brandTag;
@property (nonatomic, strong) NSString *image;
+(NSMutableArray*)getBrands;
@end

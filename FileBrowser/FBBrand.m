//
//  FBBrand.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBBrand.h"
static NSMutableArray *array;
@implementation FBBrand
+(NSMutableArray*)getBrands{
    if (array) {
        return array;
    }
    NSLog(@"Generating Brands");
    NSArray *images = @[@"gaviskon",@"veet",@"nurofen",@"clerasil",@"strepsils"];
    NSArray *name = @[@"Gaviskon",@"Veet",@"Nurofen",@"Clearasil",@" Strepsils ",@"Roundtable"];
    array = [NSMutableArray new];
    for (int i = 0; i<6; i++) {
        FBBrand *brand = [FBBrand new];
        brand.brandId = [NSString stringWithFormat:@"%ld",(long)(100+i)];
        brand.brandName = name[i];
        brand.brandTag = 100+i;
        if (i<5) {
            brand.image = images[i];
        }
        
        [array addObject:brand];
        
    }
    return array;
}
@end

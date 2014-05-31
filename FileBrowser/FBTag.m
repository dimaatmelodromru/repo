//
//  FBTag.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBTag.h"

static NSMutableArray *tags;
static NSMutableArray *detailingTags;
static NSMutableArray *libraryTags;
static NSMutableArray *educationalTags;
static NSMutableArray *toolsTags;
static NSMutableArray *myPageTags;
static NSMutableArray *skuTags;

@implementation FBTag
+ (NSMutableArray*)getTags{
    if (tags) {
        return tags;
    }
    NSLog(@"Tags Generating");
    tags = [NSMutableArray new];
    NSInteger count = 0 ;
    FBTag *tag1 = [FBTag new];
    tag1.tagName = @"Roundtable";
    tag1.tagId = @"8999aaabbbccc0000";
    tag1.tagBId = count+200;
    count++;
    
    FBTag *tag2 = [FBTag new];
    tag2.tagName = @"Must List";
    tag2.tagId = @"8999aaabbbccc0001";
    tag2.tagBId = count+200;
    count++;
    FBTag *tag3 = [FBTag new];
    tag3.tagName = @"Merchandising Skills	";
    tag3.tagId = @"8999aaabbbccc0002";
    tag3.tagBId = count+200;
    count++;
    FBTag *tag4 = [FBTag new];
    tag4.tagName = @"Packshots";
    tag4.tagId = @"8999aaabbbccc0003";
    tag4.tagBId = count+200;
    count++;
    FBTag *tag5 = [FBTag new];
    tag5.tagName = @"About Company";
    tag5.tagId = @"4999aaabbbccc0000";
    tag5.tagBId = count+200;
    count++;
    FBTag *tag6 = [FBTag new];
    tag6.tagName = @"Video";
    tag6.tagId = @"4999aaabbbccc0001";
    tag6.tagBId = count+200;
    count++;
    
    FBTag *tag7 = [FBTag new];
    tag7.tagName = @"Price List";
    tag7.tagId = @"4999aaabbbccc0002";
    tag7.tagBId = count+200;
    count++;
    FBTag *tag8 = [FBTag new];
    tag8.tagName = @"PDP/Documents";
    tag8.tagId = @"4999aaabbbccc0003";
    tag8.tagBId = count+200;
    count++;
    // //Motivational Programs
    //Activity Plan
    //Task
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"Motivational Programs";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+200;
    count++;
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"Activity Plan";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+200;
    count++;
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"Task";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+200;
    count++;
    [tags addObject:tag1];
    [tags addObject:tag2];
    [tags addObject:tag3];
    [tags addObject:tag4];
    [tags addObject:tag5];
    [tags addObject:tag6];
    [tags addObject:tag7];
    [tags addObject:tag8];
    [tags addObject:tag9];
    [tags addObject:tag10];
    [tags addObject:tag11];
    return tags;
}


+ (NSMutableArray*)getSkuTag{
    if (skuTags) {
        return skuTags;
    }
    NSLog(@"Tags Generating");
    NSInteger count = 0;
    skuTags = [NSMutableArray new];
    
    FBTag *tag = [FBTag new];
    tag.tagName = @"Strepsils Kids Strawberry N16";
    tag.tagId = @"4999aaabbbccc0003";
    tag.tagBId = count+300;
    
    FBTag *tag2 = [FBTag new];
    tag2.tagName = @"Strepsils Intensive N24";
    tag2.tagId = @"4999aaabbbccc0003";
    tag2.tagBId = count+300;
    
    FBTag *tag3 = [FBTag new];
    tag3.tagName = @"Strepsils Original N24";
    tag3.tagId = @"4999aaabbbccc0003";
    tag3.tagBId = count+300;
    
    FBTag *tag4 = [FBTag new];
    tag4.tagName = @"Strepsils Menthol N24";
    tag4.tagId = @"4999aaabbbccc0003";
    tag4.tagBId = count+300;
    
    FBTag *tag5 = [FBTag new];
    tag5.tagName = @"Strepsils Plus Spray 20 ml N1";
    tag5.tagId = @"4999aaabbbccc0003";
    tag5.tagBId = count+300;
    
    FBTag *tag6 = [FBTag new];
    tag6.tagName = @"Strepsils Plus Pills N24";
    tag6.tagId = @"4999aaabbbccc0003";
    tag6.tagBId = count+300;
    
    FBTag *tag7 = [FBTag new];
    tag7.tagName = @"Strepsils with Vitamin C N24";
    tag7.tagId = @"4999aaabbbccc0003";
    tag7.tagBId = count+300;
    
    FBTag *tag8 = [FBTag new];
    tag8.tagName = @"Strepsils with Vitamin C N36";
    tag8.tagId = @"4999aaabbbccc0003";
    tag8.tagBId = count+300;
    
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"Strepsils Warming Pills N24";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+300;
    
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"Strepsils Honey Lemon N36";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+300;
    
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"Strepsils Lemon N24";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+300;
   
    
    [skuTags addObject:tag];
    [skuTags addObject:tag2];
    [skuTags addObject:tag3];
    [skuTags addObject:tag4];
    [skuTags addObject:tag5];
    [skuTags addObject:tag6];
    [skuTags addObject:tag7];
    [skuTags addObject:tag8];
    [skuTags addObject:tag9];
    [skuTags addObject:tag10];
    [skuTags addObject:tag11];
    return skuTags;
}

+ (NSMutableArray*)getDetailingTags{
    if (detailingTags) {
        return detailingTags;
    }
    NSInteger count = 1;
    NSMutableArray *tags = [NSMutableArray new];
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"Roundtable";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+100;
    count++;
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"KM-1";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+100;
    count++;
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"KM-2";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+100;
    count++;
    [tags addObject:tag9];
    [tags addObject:tag10];
    [tags addObject:tag11];
    detailingTags = tags;
    return detailingTags;
}
+ (NSMutableArray*)getLibraryTags{
    if (libraryTags) {
        return libraryTags;
    }
    NSInteger count = 1;
    NSMutableArray *tags = [NSMutableArray new];
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"Catrgory Info";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+200;
    count++;
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"Product Info";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+200;
    count++;
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"Brand Task";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+200;
    count++;
    
    FBTag *tag12 = [FBTag new];
    tag12.tagName = @"Marketing";
    tag12.tagId = @"4999aaabbbccc0003";
    tag12.tagBId = count+200;
    count++;
    FBTag *tag13 = [FBTag new];
    tag13.tagName = @"Price List";
    tag13.tagId = @"4999aaabbbccc0003";
    tag13.tagBId = count+200;
    count++;
    FBTag *tag14 = [FBTag new];
    tag14.tagName = @"POSM";
    tag14.tagId = @"4999aaabbbccc0003";
    tag14.tagBId = count+200;
    count++;
    
    FBTag *tag15 = [FBTag new];
    tag15.tagName = @"Must List";
    tag15.tagId = @"4999aaabbbccc0003";
    tag15.tagBId = count+200;
    count++;
    FBTag *tag16 = [FBTag new];
    tag16.tagName = @"Planogramm";
    tag16.tagId = @"4999aaabbbccc0003";
    tag16.tagBId = count+200;
    count++;
    FBTag *tag17 = [FBTag new];
    tag17.tagName = @"Reprints";
    tag17.tagId = @"4999aaabbbccc0003";
    tag17.tagBId = count+200;
    count++;
    
    FBTag *tag18 = [FBTag new];
    tag18.tagName = @"Promo";
    tag18.tagId = @"4999aaabbbccc0003";
    tag18.tagBId = count+200;
    count++;
    FBTag *tag19 = [FBTag new];
    tag19.tagName = @"Video";
    tag19.tagId = @"4999aaabbbccc0003";
    tag19.tagBId = count+200;
    count++;
    FBTag *tag20 = [FBTag new];
    tag20.tagName = @"Packshots";
    tag20.tagId = @"4999aaabbbccc0003";
    tag20.tagBId = count+200;
    count++;
    
    FBTag *tag21 = [FBTag new];
    tag21.tagName = @"Instructions";
    tag21.tagId = @"4999aaabbbccc0003";
    tag21.tagBId = count+200;
    count++;
    FBTag *tag22 = [FBTag new];
    tag22.tagName = @"Reg. Number";
    tag22.tagId = @"4999aaabbbccc0003";
    tag22.tagBId = count+200;
    count++;
   
    [tags addObject:tag9];
    [tags addObject:tag10];
    [tags addObject:tag11];
    [tags addObject:tag12];
    [tags addObject:tag13];
    [tags addObject:tag14];
    [tags addObject:tag15];
    [tags addObject:tag16];
    [tags addObject:tag17];
    [tags addObject:tag18];
    [tags addObject:tag19];
    [tags addObject:tag20];
    [tags addObject:tag21];
    [tags addObject:tag22];
    libraryTags = tags;
    return libraryTags;
}
+ (NSMutableArray*)getToolsTags{
    if (toolsTags) {
        return toolsTags;
    }
    NSInteger count = 1;
    NSMutableArray *tags = [NSMutableArray new];
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"Promo Action";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+300;
    count++;
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"PDP/Mechanics";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+300;
    count++;
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"PDP/Documents";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+300;
    count++;
    
    FBTag *tag12 = [FBTag new];
    tag12.tagName = @"Sell-In/Mechanics";
    tag12.tagId = @"4999aaabbbccc0003";
    tag12.tagBId = count+300;
    count++;
    FBTag *tag13 = [FBTag new];
    tag13.tagName = @"Price List";
    tag13.tagId = @"4999aaabbbccc0003";
    tag13.tagBId = count+300;
    count++;
    FBTag *tag14 = [FBTag new];
    tag14.tagName = @"POSM";
    tag14.tagId = @"4999aaabbbccc0003";
    tag14.tagBId = count+300;
    count++;
    
    FBTag *tag15 = [FBTag new];
    tag15.tagName = @"Must List";
    tag15.tagId = @"4999aaabbbccc0003";
    tag15.tagBId = count+300;
    count++;
    FBTag *tag16 = [FBTag new];
    tag16.tagName = @"Planogramm";
    tag16.tagId = @"4999aaabbbccc0003";
    tag16.tagBId = count+300;
    count++;
    FBTag *tag17 = [FBTag new];
    tag17.tagName = @"Sell-In/Documents";
    tag17.tagId = @"4999aaabbbccc0003";
    tag17.tagBId = count+300;
    count++;
    
    [tags addObject:tag9];
    [tags addObject:tag10];
    [tags addObject:tag11];
    [tags addObject:tag12];
    [tags addObject:tag13];
    [tags addObject:tag14];
    [tags addObject:tag15];
    [tags addObject:tag16];
    [tags addObject:tag17];
    toolsTags = tags;
    return toolsTags;
}
+ (NSMutableArray*)getEducationaTags{
    if (educationalTags) {
        return educationalTags;
    }
    NSInteger count = 1;
    NSMutableArray *tags = [NSMutableArray new];
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"About Company";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+400;
    count++;
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"Channel Specs";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+400;
    count++;
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"Sales Skills";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+400;
    count++;
    
    FBTag *tag12 = [FBTag new];
    tag12.tagName = @"Merchandising Skills";
    tag12.tagId = @"4999aaabbbccc0003";
    tag12.tagBId = count+400;
    count++;
    FBTag *tag13 = [FBTag new];
    tag13.tagName = @"Leadership Skills";
    tag13.tagId = @"4999aaabbbccc0003";
    tag13.tagBId = count+400;
    count++;
    FBTag *tag14 = [FBTag new];
    tag14.tagName = @"Video";
    tag14.tagId = @"4999aaabbbccc0003";
    tag14.tagBId = count+400;
    count++;
    
    [tags addObject:tag9];
    [tags addObject:tag10];
    [tags addObject:tag11];
    [tags addObject:tag12];
    [tags addObject:tag13];
    [tags addObject:tag14];
    educationalTags = tags;
    return educationalTags;
}
+ (NSMutableArray*)getMyPageTags{
    if (myPageTags) {
        return myPageTags;
    }
    NSInteger count = 1;
    NSMutableArray *tags = [NSMutableArray new];
    FBTag *tag9 = [FBTag new];
    tag9.tagName = @"Motivational Programs";
    tag9.tagId = @"4999aaabbbccc0003";
    tag9.tagBId = count+500;
    count++;
    FBTag *tag10 = [FBTag new];
    tag10.tagName = @"Activity Plan";
    tag10.tagId = @"4999aaabbbccc0003";
    tag10.tagBId = count+500;
    count++;
    FBTag *tag11 = [FBTag new];
    tag11.tagName = @"Task";
    tag11.tagId = @"4999aaabbbccc0003";
    tag11.tagBId = count+500;
    count++;
    [tags addObject:tag9];
    [tags addObject:tag10];
    [tags addObject:tag11];
    return myPageTags = tags;
}
@end

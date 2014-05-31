//
//  FBFile.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBFile.h"
#import "FBBrand.h"
#import "FBTag.h"

@implementation FBFile
- (instancetype)init{
    self = [super init];
    if (self) {
        _fileCategoryTags = [NSMutableArray new];
    }
    return self;
}
+(NSMutableArray*)getBrands{
    return [FBBrand getBrands];
}
+ (NSMutableArray*)getDetailingFiles{
    NSMutableArray *brands = [FBFile getBrands];
    NSMutableArray *files = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Gaviskon";
    file1.fileName = @"index";
    file1.fileType = @"html";
    file1.fileThumbnail = @"200x150.jpg";
    
    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[0], nil];
    
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"Gaviskon Mini";
    file2.fileName = @"index1";
    file2.fileType = @"html";
    file2.fileThumbnail = @"200x150.jpg";
    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[0],brands[1],brands[4], nil];
    
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"Sell in-Veet";
    file3.fileName = @"detailing1";
    file3.fileType = @"pdf";
    file3.fileThumbnail = @"detalingicon.jpg";
    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[4],brands[3], nil];
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"Detailing 2";
    file4.fileName = @"detailing2";
    file4.fileType = @"pdf";
    file4.fileThumbnail = @"detalingicon.jpg";

    NSMutableArray *tags = [FBTag getDetailingTags];
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0], nil];
//    file2.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[1],tags[3], nil];
//    file3.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[1],tags[4], nil];
    
    [files addObject:file1];
    //[files addObject:file2];
    //[files addObject:file3];
    //[files addObject:file4];
    return files;
}
+ (NSMutableArray*)getLibraryFiles{
    NSMutableArray *files = [NSMutableArray new];
    NSMutableArray *skuTags = [FBTag getSkuTag];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Veet Must List SUMMER April 2014";
    file1.fileName = @"lib1";
    file1.fileType = @"xlsx";
   ;
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"Veet Must List SUMMER May-September 2014";
    file2.fileName = @"lib2";
    file2.fileType = @"xlsx";
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"Strepsils Commercial - Myth Busters";
    file3.fileName = @"lib3";
    file3.fileType = @"mp4";
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"Clearasil Commercial";
    file4.fileName = @"lib4";
    file4.fileType = @"m4v";
    
    FBFile *file5 = [FBFile new];
    file5.fileTitle = @"Veet Must List SUMMER May-September 2014";
    file5.fileName = @"lib5";
    file5.fileType = @"pdf";
    FBFile *file6 = [FBFile new];
    file6.fileTitle = @"Registracionnoe udostoverenie Strepsils dlya detey bez sahara limon ü16";
    file6.fileName = @"lib6";
    file6.fileType = @"pdf";
    FBFile *file7 = [FBFile new];
    file7.fileTitle = @"Clearasil Commercial";
    file7.fileName = @"lib7";
    file7.fileType = @"pdf";
    
    FBFile *file8 = [FBFile new];
    file8.fileTitle = @"Nurofen Price List 01.04.14";
    file8.fileName = @"lib8";
    file8.fileType = @"xls";
    
    FBFile *file9 = [FBFile new];
    file9.fileTitle = @"POSM Nurofen";
    file9.fileName = @"lib9";
    file9.fileType = @"ppt";
    
    FBFile *file10 = [FBFile new];
    file10.fileTitle = @"ПРОМО Деттол";
    file10.fileName = @"lib10";
    file10.fileType = @"ppt";

    FBFile *file11 = [FBFile new];
    file11.fileTitle = @"Дополнительная информация для торговых представителей";
    file11.fileName = @"lib11";
    file11.fileType = @"pptx";
    //.pptx
    //.ppt
    NSMutableArray *brands = [FBFile getBrands];
    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[1], nil];
    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[1], nil];
    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[4], nil];
    file4.fileBrands = [NSMutableArray arrayWithObjects:brands[3], nil];
    file5.fileBrands = [NSMutableArray arrayWithObjects:brands[1], nil];
    file6.fileBrands = [NSMutableArray arrayWithObjects:brands[4], nil];
    file7.fileBrands = [NSMutableArray arrayWithObjects:brands[4], nil];
    file8.fileBrands = [NSMutableArray arrayWithObjects:brands[2], nil];
    file9.fileBrands = [NSMutableArray arrayWithObjects:brands[2], nil];
    
    NSMutableArray *tags = [FBTag getLibraryTags];
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[6], nil];
    file2.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[6], nil];
    file3.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[10], nil];
    file4.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[10], nil];
    file5.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[6], nil];
    file6.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[3], nil];
    file7.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[3], nil];
    file8.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[4], nil];
    file9.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[5], nil];
    file10.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[9], nil];
    file11.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[9], nil];
    
    file5.skuTag = [skuTags objectAtIndex:0];
    file6.skuTag = [skuTags objectAtIndex:3];
    file7.skuTag = [skuTags objectAtIndex:6];
    /*FBFile *file5 = [FBFile new];
    file5.fileTitle = @"Veet";
    file5.fileName = @"lib5";
    file5.fileType = @"xlsx";
    
    FBFile *file6 = [FBFile new];
    file6.fileTitle = @"Library 6";
    file6.fileName = @"lib6";
    file6.fileType = @"xls";
    
    FBFile *file7 = [FBFile new];
    file7.fileTitle = @"Library 7";
    file7.fileName = @"lib6";
    file7.fileType = @"xls";*/
    
//    file7.fileThumbnail = @"library.png";
//    file6.fileThumbnail = @"library.png";
//    file5.fileThumbnail = @"library.png";
    file1.fileThumbnail = @"library.png";
    file2.fileThumbnail = @"library.png";
    file3.fileThumbnail = @"library.png";
    file4.fileThumbnail = @"library.png";
    
    
//    file5.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[1],brands[3], nil];
//    file6.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[4],brands[3], nil];
//    file7.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[2],brands[3], nil];
    
    
//    file5.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[5],tags[3],tags[1], nil];
//    file6.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[1],tags[4], nil];
//    file7.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[1],tags[4], nil];
    
    [files addObject:file1];
    [files addObject:file2];
    [files addObject:file3];
    [files addObject:file4];
    [files addObject:file5];
    [files addObject:file6];
    //[files addObject:file7];
    [files addObject:file8];
    [files addObject:file9];
    [files addObject:file10];
    [files addObject:file11];
    return files;
}
+ (NSMutableArray*)getToolFiles{
    NSMutableArray *files = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Пакет инструментов для сетевых аптек";
    file1.fileName = @"tool1";
    file1.fileType = @"pdf";
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"Пакет инструментов для независимой розницы";
    file2.fileName = @"tool2";
    file2.fileType = @"pdf";
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"МАРКЕТИНГОВЫЙ ПЛАН НА 2014 год";
    file3.fileName = @"tool3";
    file3.fileType = @"doc";
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"МАРКЕТИНГОВЫЙ ПЛАН НА 2014 год";
    file4.fileName = @"tool4";
    file4.fileType = @"doc";
    
    FBFile *file5 = [FBFile new];
    file5.fileTitle = @"Pamjatka dlja aptek PDP";
    file5.fileName = @"tool5";
    file5.fileType = @"doc";
    
    FBFile *file6 = [FBFile new];
    file6.fileTitle = @"novyj pasport pdp obrazets raznye protsenty prirosta";
    file6.fileName = @"tool6";
    file6.fileType = @"doc";
    FBFile *file7 = [FBFile new];
    file7.fileTitle = @"novyj pasport pdp obrazets";
    file7.fileName = @"tool6";
    file7.fileType = @"doc";
    FBFile *file8 = [FBFile new];
    file8.fileTitle = @"Pnovyj pasport pdp";
    file8.fileName = @"tool8";
    file8.fileType = @"doc";
    FBFile *file9 = [FBFile new];
    file9.fileTitle = @"PDP 2014_chains";
    file9.fileName = @"tool9";
    file9.fileType = @"pdf";
    FBFile *file10 = [FBFile new];
    file10.fileTitle = @"PDP 2014_Independent";
    file10.fileName = @"tool10";
    file10.fileType = @"pdf";
    
    
    //Pamjatka dlja aptek PDP
    file1.fileThumbnail = @"toolicon.png";
    file2.fileThumbnail = @"toolicon.png";
    file3.fileThumbnail = @"toolicon.png";
    file4.fileThumbnail = @"toolicon.png";
    
//    NSMutableArray *brands = [FBFile getBrands];
//    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[1],brands[3],brands[5], nil];
//    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[2],brands[4], nil];
//    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[1],brands[3], nil];
//    file4.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[3],brands[8], nil];
    NSMutableArray *tags = [FBTag getToolsTags];
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    file2.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    file3.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[3], nil];
    file4.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    
    file5.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    file6.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[3], nil];
    file7.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    file8.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    file9.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[1], nil];
    file10.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[1], nil];
    
    [files addObject:file1];
    [files addObject:file2];
    [files addObject:file3];
    [files addObject:file4];
    [files addObject:file5];
    [files addObject:file6];
    [files addObject:file7];
    [files addObject:file8];
    [files addObject:file9];
    [files addObject:file10];
    return files;
}
+ (NSMutableArray*)getEducationalFiles{
     NSMutableArray *tags = [FBTag getEducationaTags];
    NSMutableArray *files = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"company info";
    file1.fileName = @"edu1";
    file1.fileType = @"ppt";
    
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"Дисплей Нурофен горизонтальный";
    file2.fileName = @"edu2";
    file2.fileType = @"ppt";
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"Reckitt Benckiser (RB)";
    file3.fileName = @"edu3";
    file3.fileType = @"ppt";
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"Что поможет нам вырасти в 2014 году";
    file4.fileName = @"edu4";
    file4.fileType = @"pptx";
    
    FBFile *file5 = [FBFile new];
    file5.fileTitle = @"RB Key values";
    file5.fileName = @"edu6";
    file5.fileType = @"m4v";
    
    FBFile *file6 = [FBFile new];
    file6.fileTitle = @"Merchandising skills";
    file6.fileName = @"edu7";
    file6.fileType = @"pdf";
    
    file1.fileThumbnail = @"educationicon.jpg";
    file2.fileThumbnail = @"educationicon.jpg";
    file3.fileThumbnail = @"educationicon.jpg";
    file4.fileThumbnail = @"educationicon.jpg";
    file5.fileThumbnail = @"educationicon.jpg";
    
//    NSMutableArray *brands = [FBFile getBrands];
//    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[1],brands[3],brands[5], nil];
//    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[2],brands[4], nil];
//    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[2],brands[1],brands[3], nil];
//    file4.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[4],brands[5], nil];
//    file5.fileBrands = [NSMutableArray arrayWithObjects:brands[4],brands[4],brands[5], nil];
    
   
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0], nil];
    file2.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[1], nil];
    file3.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2], nil];
    file4.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[3], nil];
    file5.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[5], nil];
    file6.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[3], nil];
    
    [files addObject:file1];
    [files addObject:file2];
    [files addObject:file3];
    [files addObject:file4];
    [files addObject:file5];
    [files addObject:file6];
    return files;
}
+ (NSMutableArray*)getMyPageFiles{
    NSMutableArray *files = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Tasks and Priorities - april 2014";
    file1.fileName = @"mypage";
    file1.fileType = @"ppt";
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"My Page 2";
    file2.fileName = @"mypage2";
    file2.fileType = @"pdf";
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"My Page 3";
    file3.fileName = @"mypage3";
    file3.fileType = @"pdf";
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"My Page 4";
    file4.fileName = @"mypage4";
    file4.fileType = @"pdf";
    
    file1.fileThumbnail = @"mypageicon.jpg";
    file2.fileThumbnail = @"mypageicon.jpg";
    file3.fileThumbnail = @"mypageicon.jpg";
    file4.fileThumbnail = @"mypageicon.jpg";
    
//    NSMutableArray *brands = [FBFile getBrands];
//    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[1],brands[3],brands[5], nil];
//    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[2],brands[4], nil];
//    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[2],brands[1],brands[3], nil];
//    file4.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[4],brands[5], nil];
    
    NSMutableArray *tags = [FBTag getMyPageTags];
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[2], nil];
    
    
    
    [files addObject:file1];
    //[files addObject:file2];
    //[files addObject:file3];
    //[files addObject:file4];
    return files;
}
+ (NSMutableArray*)getQuestionnaierFiles{
    NSMutableArray *files = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Questionnaier 1";
    file1.fileName = @"ques1";
    file1.fileType = @"pdf";
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"Questionnaier 2";
    file2.fileName = @"ques2";
    file2.fileType = @"pdf";
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"Questionnaier 3";
    file3.fileName = @"ques3";
    file3.fileType = @"pdf";
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"Questionnaier 4";
    file4.fileName = @"ques4";
    file4.fileType = @"pdf";
    
    file1.fileThumbnail = @"quesicon.jpg";
    file2.fileThumbnail = @"quesicon.jpg";
    file3.fileThumbnail = @"quesicon.jpg";
    file4.fileThumbnail = @"quesicon.jpg";
    NSMutableArray *brands = [FBFile getBrands];
    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[1],brands[3],brands[5], nil];
    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[2],brands[4], nil];
    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[2],brands[1],brands[3], nil];
    
    NSMutableArray *tags = [FBTag getTags];
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[1],tags[2], nil];
    file2.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[4],tags[5], nil];
    file3.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[1],tags[2],tags[3], nil];
    file4.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2],tags[3],tags[4], nil];
    
    
    /*[files addObject:file1];
    [files addObject:file2];
    [files addObject:file3];
    [files addObject:file4];*/
    return files;
}
+ (NSMutableArray*)getLiveChatFiles{
    NSMutableArray *files = [NSMutableArray new];
    FBFile *file1 = [FBFile new];
    file1.fileTitle = @"Live Chat";
    file1.fileName = @"live1";
    file1.fileType = @"html";
    FBFile *file2 = [FBFile new];
    file2.fileTitle = @"Live Chat 2";
    file2.fileName = @"live2";
    file2.fileType = @"pdf";
    FBFile *file3 = [FBFile new];
    file3.fileTitle = @"Live Chat 3";
    file3.fileName = @"live3";
    file3.fileType = @"pdf";
    FBFile *file4 = [FBFile new];
    file4.fileTitle = @"Live Chat 4";
    file4.fileName = @"live4";
    file4.fileType = @"pdf";
    
    file1.fileThumbnail = @"livechat.png";
    file2.fileThumbnail = @"livechat.png";
    file3.fileThumbnail = @"livechat.png";
    file4.fileThumbnail = @"livechat.png";
    
    /*NSMutableArray *brands = [FBFile getBrands];
    file1.fileBrands = [NSMutableArray arrayWithObjects:brands[1],brands[3],brands[5], nil];
    file2.fileBrands = [NSMutableArray arrayWithObjects:brands[5],brands[2],brands[4], nil];
    file3.fileBrands = [NSMutableArray arrayWithObjects:brands[2],brands[1],brands[3], nil];
    
    NSMutableArray *tags = [FBTag getTags];
    file1.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[1],tags[2], nil];
    file2.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[0],tags[4],tags[5], nil];
    file3.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[1],tags[2],tags[3], nil];
    file4.fileCategoryTags = [NSMutableArray arrayWithObjects:tags[2],tags[3],tags[4], nil];*/
    
    [files addObject:file1];
    /*[files addObject:file2];
    [files addObject:file3];
    [files addObject:file4];*/
    return files;
}

@end

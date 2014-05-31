//
//  FBTileView.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBTileView.h"
#import "FBFile.h"

#define SIDE_MARGIN     10
#define TOP_MARGIN      10
#define ITEM_SPACING    10

@interface FBTileView ()
@property (nonatomic, strong) FBFile *file;
@end

@implementation FBTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame andFile:(FBFile*)file{
    self = [super initWithFrame:frame];
    if (self) {
        _file = file;
        [self setup];
    }
    return self;
}
-(FBFile*)file{
    return _file;
}
- (NSString*)getFileIcon:(FBFile*)file{
    NSString *icon = @"mypageicon.jpg";
    
    if ([file.fileType isEqualToString:@"pdf"]) {
        icon = @"file_icon_4.png";
    }
    else if ([file.fileType isEqualToString:@"doc"]||([file.fileType isEqualToString:@"docx"])){
        icon = @"file_icon_1.png";
    }
    else if ([file.fileType isEqualToString:@"xls"]||([file.fileType isEqualToString:@"xlsx"])){
        icon = @"file_icon_2.png";
    }
    else if ([file.fileType isEqualToString:@"ppt"] || ([file.fileType isEqualToString:@"pptx"])){
        icon = @"file_icon_3.png";
    }
    else if ([file.fileType isEqualToString:@"mp4"] || ([file.fileType isEqualToString:@"m4v"]|| ([file.fileType isEqualToString:@"mpg"])|| ([file.fileType isEqualToString:@"mpeg"]))){
        icon = @"file_icon_5.png";
    }
    else if ([file.fileType isEqualToString:@"jpeg"] || ([file.fileType isEqualToString:@"png"])){
        icon = @"file_icon_6.png";
    }
    else if ([file.fileType isEqualToString:@"zip"]){
        icon = @"file_icon_7.png";
    }
    return icon;
}
- (void)setup{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SIDE_MARGIN, TOP_MARGIN, 52, 52)];
    [self addSubview:imageView];
    
    UILabel *filenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_MARGIN + imageView.frame.size.width+SIDE_MARGIN+ITEM_SPACING-6 , TOP_MARGIN,self.frame.size.width-(imageView.frame.size.width+SIDE_MARGIN+SIDE_MARGIN+ITEM_SPACING+SIDE_MARGIN),(_file.fileName.length > 25)?50:30)];
    filenameLabel.backgroundColor = [UIColor redColor];
    filenameLabel.numberOfLines = (_file.fileName.length > 25)?2:1;
    filenameLabel.textAlignment = NSTextAlignmentLeft;
    //[filenameLabel setNumberOfLines:0];
    //[filenameLabel sizeToFit];
    
    filenameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    filenameLabel.font = [UIFont systemFontOfSize:16];
    filenameLabel.backgroundColor = [UIColor clearColor];
    filenameLabel.textColor =  [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    filenameLabel.font = [UIFont systemFontOfSize:20];//[UIFont fontWithName:@"DINPro-Medium" size:20.0];
    [self addSubview:filenameLabel];
    
//    UILabel *fileTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_MARGIN + imageView.frame.size.width+SIDE_MARGIN+ITEM_SPACING-6 , TOP_MARGIN+filenameLabel.frame.size.height,self.frame.size.width-SIDE_MARGIN-SIDE_MARGIN-ITEM_SPACING-SIDE_MARGIN,20.0)];
//    fileTypeLabel.font = [UIFont systemFontOfSize:20];//[UIFont fontWithName:@"DINPro-Medium" size:20.0];
//    fileTypeLabel.textColor =  [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
//    
//    [self addSubview:fileTypeLabel];
    
    imageView.image =[UIImage imageNamed:[self getFileIcon:_file]];
    filenameLabel.text = _file.fileTitle;
    
    //fileTypeLabel.text = _file.fileType;
    //fileTypeLabel.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTileView:)];
    [self addGestureRecognizer:gestureRec];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
}
- (void)onTapTileView:(id)sender{
    [self.delegate fbTileViewDidTaped:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

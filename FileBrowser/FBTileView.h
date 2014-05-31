//
//  FBTileView.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFile.h"

@class FBTileView;
@protocol FBTileViewDelegate

- (void)fbTileViewDidTaped:(FBTileView*)tileView;

@end
@interface FBTileView : UIView
@property (nonatomic, weak) id<FBTileViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame andFile:(FBFile*)file;
- (FBFile*)file;
@end

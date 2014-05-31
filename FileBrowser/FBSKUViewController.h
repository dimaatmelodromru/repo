//
//  FBSKUViewController.h
//  FileBrowser
//
//  Created by Adnan Aftab on 5/4/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTag.h"

@class FBSKUViewController;

@protocol FBSKUViewControllerDelegate

- (void)skuViewController:(FBSKUViewController*)viewController didSelectSku:(FBTag*)skuTag;

@end

@interface FBSKUViewController : UIViewController
@property (nonatomic, weak) id<FBSKUViewControllerDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *skuTags;
- (id)initWithFrame:(CGRect)frame;
@end

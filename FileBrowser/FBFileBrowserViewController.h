//
//  FBFileBrowserViewController.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FBFileBrowserViewController : FBBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *statusBarTitle;

@property (weak, nonatomic) IBOutlet UIButton *detailingButton;
@property (weak, nonatomic) IBOutlet UIButton *libraryButton;
@property (weak, nonatomic) IBOutlet UIButton *toolButton;
@property (weak, nonatomic) IBOutlet UIButton *educationalButton;
@property (weak, nonatomic) IBOutlet UIButton *myPageButton;
@property (weak, nonatomic) IBOutlet UIButton *questionierButton;
@property (weak, nonatomic) IBOutlet UIButton *liveChatButton;
@property (nonatomic, strong) NSString *userName;
@property (strong, nonatomic) IBOutlet UIScrollView *categoriesScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;

- (IBAction)onTapDetailingButton:(id)sender;
- (IBAction)libraryButton:(id)sender;
- (IBAction)onTapToolButton:(id)sender;
- (IBAction)onTapEducationalButton:(id)sender;
- (IBAction)onTapMyPage:(id)sender;
- (IBAction)onTapQuestionierButton:(id)sender;
- (IBAction)onTapLiveChatButton:(id)sender;

@end

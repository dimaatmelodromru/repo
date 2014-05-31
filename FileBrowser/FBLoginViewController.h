//
//  FBLoginViewController.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBLoginViewController : FBBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *signInlabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIView *loginBackView;

@end

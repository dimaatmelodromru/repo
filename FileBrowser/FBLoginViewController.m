//
//  FBLoginViewController.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBLoginViewController.h"
#import "FBFileBrowserViewController.h"

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //rgb(25,25,112)
    self.loginBackView.layer.cornerRadius = 5;
    self.loginBackView.layer.masksToBounds = YES;
    _loginButton.backgroundColor = [UIColor colorWithRed:25 green:25 blue:112 alpha:1];
    _usernameTextField.layer.cornerRadius = 5;
    _usernameTextField.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    _usernameTextField.layer.masksToBounds = YES;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    //_passwordTextField.transform = CGAffineTransformMakeScale(1.0, 1.50);
    //_usernameTextField.transform = CGAffineTransformMakeScale(1.0, 1.50);
    _loginLabel.font = [UIFont boldSystemFontOfSize:20];//[UIFont fontWithName:@"DINPro-Medium" size:20];
    _passwordLabel.font = [UIFont boldSystemFontOfSize:20];//[UIFont fontWithName:@"DINPro-Medium" size:20];
    _loginLabel.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    _passwordLabel.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    
    _signInlabel.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1];
    _signInlabel.font = [UIFont boldSystemFontOfSize:30.0];//[UIFont fontWithName:@"DINPro-Medium" size:30];
    _usernameTextField.font = [UIFont systemFontOfSize:25.0];//[UIFont fontWithName:@"DINPro-Medium" size:25.0];
    _passwordTextField.font  = [UIFont systemFontOfSize:25.0];//[UIFont fontWithName:@"DINPro-Medium" size:25.0];
    _okButton.titleLabel.font = [UIFont systemFontOfSize:25];//[UIFont fontWithName:@"DINPro-Medium" size:25.0];
    [_okButton setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    FBFileBrowserViewController *fileBVC = [segue destinationViewController] ;
    fileBVC.userName = _usernameTextField.text;
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([_usernameTextField.text length] == 0 || [_passwordTextField.text length] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Username and password can not be empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return NO;
    }
    return YES;
}
@end

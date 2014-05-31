//
//  FBWebViewController.h
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBFile.h"
@interface FBWebViewController : FBBaseViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *filePath;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) FBFile *file;
@property (nonatomic, strong) NSString *userName;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *messageButton;

@end

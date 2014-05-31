//
//  FBWebViewController.m
//  FileBrowser
//
//  Created by Adnan Aftab on 4/24/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBWebViewController.h"

@interface NSURLProtocolCustom : NSURLProtocol
{
    NSURLRequest *request;
}

@property (nonatomic, retain) NSURLRequest *request;


@end

@implementation NSURLProtocolCustom

@synthesize request;

+ (BOOL)canInitWithRequest:(NSURLRequest*)theRequest
{
    if ([theRequest.URL.scheme caseInsensitiveCompare:@"myapp"] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest*)theRequest
{
    return theRequest;
}

- (void)startLoading
{
    NSLog(@"%@", request.URL);
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[request URL]
                                                        MIMEType:@"image/png"
                                           expectedContentLength:-1
                                                textEncodingName:nil];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [[self client] URLProtocol:self didLoadData:data];
    [[self client] URLProtocolDidFinishLoading:self];
}

- (void)stopLoading
{
    NSLog(@"something went wrong!");
}

@end
///
@interface FBWebViewController ()<NSURLConnectionDelegate>
@property (nonatomic, assign) BOOL authed;
@property (nonatomic, assign) BOOL isFirstTime;
@end

@implementation FBWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)onTapBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = YES;
    UIImage *gradientImage32 = [[UIImage imageNamed:@"navbar2_05.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.navigationController.navigationBar setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
    self.title = _file.fileTitle;
    self.isFirstTime = YES;
    if ([_file.fileTitle isEqualToString:@"Чат"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://chat.melodrom.ru/c.php?user=%@",_userName]]]];
        /*self.navigationController.navigationBarHidden = YES;
        UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
        [back addTarget:self action:@selector(onTapBack) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(0, 0, 50, 33);
        [back setTitle:@"Back" forState:UIControlStateNormal];
        [self.view addSubview:back];
        self.webView.frame = CGRectMake(self.webView.frame.origin.x, 43, self.webView.frame.size.width, self.webView.frame.size.height-33);*/
    }
    else if([_file.fileTitle isEqualToString:@"Анкетирование"]){
        /*
         NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"qust" ofType:@"html"];
         NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
         [self.webView loadHTMLString:htmlString baseURL:nil];
        */
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://firstuser:firstuser@ls.melodrom.ru/pharm/forms/form.php"]]];
        /*self.navigationController.navigationBarHidden = YES;
        UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
        [back addTarget:self action:@selector(onTapBack) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(0, 0, 50, 33);
        [back setTitle:@"Back" forState:UIControlStateNormal];
        [self.view addSubview:back];
        self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y+33, self.webView.frame.size.width, self.webView.frame.size.height-33);*/
    }
    else{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_file.fileName ofType:_file.fileType];
        NSArray  *yourFolderContents = [[NSFileManager defaultManager]
                                        contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] resourcePath]] error:nil];
        
        
        if ([_file.fileType rangeOfString:@"zip"].location != NSNotFound) {
            //NSFileManager *filemgr =[NSFileManager defaultManager];
            self.navigationController.navigationBarHidden = YES;
            UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
            [back addTarget:self action:@selector(onTapBack) forControlEvents:UIControlEventTouchUpInside];
            back.frame = CGRectMake(0, 0, 80, 33);
            [back setTitle:@"Закрыть" forState:UIControlStateNormal];
            [self.view addSubview:back];
#ifndef full
            NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                    NSUserDomainMask, YES);
            
            NSString *docsDir = [dirPaths objectAtIndex:0];
            
            docsDir = [docsDir stringByAppendingPathComponent:_file.fileName];
            // Add www/index.html to the basepath
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
            
            // Add www/index.html to the basepath
            NSString *fullFilepath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/index.html",_file.fileName,_file.fileName]];// This must be filled in with your code
            // Load the file, assuming it exists
            NSError *err;
            NSString *html = [NSString stringWithContentsOfFile:fullFilepath encoding:NSUTF8StringEncoding error:&err];
            if (!html) {
                fullFilepath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/index.html",_file.fileName]];// This must be filled in with your code
                html = [NSString stringWithContentsOfFile:fullFilepath encoding:NSUTF8StringEncoding error:&err];
            }
            // Check to ensure base element doesn't already exist
            if ([html rangeOfString:@"<base"].location == NSNotFound) {
                // HTML doesn't contain a base url tag
                // Replace head with head and base tag
                NSString *headreplacement = [NSString stringWithFormat:@"<head><base href=\"%@\">", [fullFilepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                html = [html stringByReplacingOccurrencesOfString:@"<head>" withString:headreplacement];
                [html writeToFile:fullFilepath atomically:YES encoding:NSUTF8StringEncoding error:&err];
            }
            //NSString *finalHtml = @"<!DOCTYPE HTML />";
#endif
            
            //[self.webView loadHTMLString:html baseURL:[NSURL URLWithString:fullFilepath]];
            [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:[fullFilepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

            //NSLog(@"HTML %@",html);
            
        }
        else{
            if (filePath) {
                NSURL *filePathURL = [NSURL fileURLWithPath:filePath];
                [self.webView loadRequest:[NSURLRequest requestWithURL:filePathURL]];
            }
        }
        
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Закрыть" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBack)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Start loading");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Loading error %@",error);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"Loading finish");
}
- (void)onTick{
    self.messageButton.title = @"Form sent";
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([self.file.fileName isEqualToString:@"Live Chat"]) {
        return YES;
    }
    if (_isFirstTime) {
        _isFirstTime = NO;
        return YES;
        
    }
    self.messageButton.title = @"Sending...";
    self.toolBar.hidden = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(onTick) userInfo:nil repeats:NO];
    return YES;
}
@end

//
//  HSupport.m
//  Giftee-User
//
//  Created by Viktor Kumanenkov on 20.03.14.
//  Copyright (c) 2014 Giftee. All rights reserved.
//

#import "HSupport.h"
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

static int loadersCounter;
@implementation HSupport
UIAlertView *progressAlert;
UIActivityIndicatorView *activityView;

+(BOOL) isIOS7{
    if (IS_OS_7_OR_LATER) return YES;
    return NO;
}


+(BOOL) isEmailValid:(NSString*)email{
    if ([email isEqualToString:@""]) return NO;
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if  ([emailTest evaluateWithObject:email] != YES && [email length]!=0)
    {
        return NO;
    }else{
        return YES;
    }
    
}

+(void) showMessage:(NSString*)messageText{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle: @"Информация"
                                                      message: messageText
                                                     delegate: self
                                            cancelButtonTitle: @"OK"
                                            otherButtonTitles: nil];
    [message show];
    //uncomment for nonARC    [message release];
    
}

+(void) showError:(NSString*)messageText{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle: @"Ошибка"
                                                      message: messageText
                                                     delegate: self
                                            cancelButtonTitle: @"OK"
                                            otherButtonTitles: nil];
    [message show];
    //uncomment for nonARC    [message release];
    
}

+(void) prepareLoader{
    progressAlert = [[UIAlertView alloc] initWithTitle: @""
                                               message: @"Получение данных..."
                                              delegate: self
                                     cancelButtonTitle: nil
                                     otherButtonTitles: nil];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.frame = CGRectMake(139.0f-18.0f, 60.0f, 37.0f, 37.0f);
    [progressAlert addSubview:activityView];
    
    
}

+(void) showLoader{
    [self prepareLoader];
    [activityView startAnimating];
    [progressAlert show];
    //uncomment for nonARC
    //[progressAlert release];
    
}

+(void) showLoaderWithDelegate:(id)delegate{
    progressAlert = [[UIAlertView alloc] initWithTitle: @""
                                               message: @"Получение данных..."
                                              delegate: delegate
                                     cancelButtonTitle: @"Отменить"
                                     otherButtonTitles: nil];
    progressAlert.delegate = delegate;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //activityView.tintColor = [UIColor blueColor];
    //activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.frame = CGRectMake(139.0f-18.0f, 60.0f, 37.0f, 37.0f);
    [progressAlert addSubview:activityView];
    [activityView startAnimating];
    [progressAlert show];
    //uncomment for nonARC
    //[progressAlert release];
    
}
+(void) hideLoader{
    [activityView stopAnimating];
    if (progressAlert != nil)
        [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    
}

+(NSData*) loadImage:(NSString*)imageURL{
    if ([imageURL isEqualToString:@""]) {
        UIImage *img = [UIImage imageNamed:@"noimage"];
        return UIImagePNGRepresentation(img);
    }
    NSString* urlTextEscaped = [imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   return  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlTextEscaped]];
}

+(void) setNavigationTitleColor:(UIColor*)color{
 UIFont *naviFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
 NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                color,
                                UITextAttributeTextColor,
                                [UIColor clearColor],
                                UITextAttributeTextShadowColor,
                                naviFont,
                                UITextAttributeFont, nil];

    [[UIBarButtonItem appearance] setTitleTextAttributes: attributes
                                                forState: UIControlStateNormal];

}

+ (UIImage*) imageWithColor:(UIColor*)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    UIBezierPath* rPath = [UIBezierPath bezierPathWithRect:CGRectMake(0., 0., size.width, size.height)];
    [color setFill];
    [rPath fill];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

+ (void) loadFromURL_: (FBFile*)fbfile  {
//    NSURL *url = [NSURL URLWithString:@"http://pharm.melodrom.ru/shares/default/files/1_Дитейлинг/Gaviscon/KM-1/КМ-1 март-апр'14. Гевискон.zip"];
    loadersCounter++;
    NSURL *url = [NSURL URLWithString:[fbfile.fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *uInfo = [NSDictionary dictionaryWithObject:fbfile.fileName forKey:@"fileName"];
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"fileLoaded" object:self userInfo:uInfo];
            //выпиливаем подкаталоги из урла, чтобы потом их создать их в /Documents/
            NSArray *splitPath = [[NSArray alloc] initWithArray:[fbfile.fileLocalPath componentsSeparatedByCharactersInSet:[NSCharacterSet  characterSetWithCharactersInString:@"/"]]];
            NSString *storePath = DOCSFOLDER;
            //создаем каталоги, если есть необходимость
            for (int i=0; i<[splitPath count]-1; i++) {
                storePath = [storePath stringByAppendingString:splitPath[i]];
                BOOL isDir=NO;
                [[NSFileManager defaultManager] fileExistsAtPath:storePath isDirectory:&isDir];
                if (!isDir) {
                    NSError *error = nil;
                    NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                                     forKey:NSFileProtectionKey];
                    [[NSFileManager defaultManager] createDirectoryAtPath:storePath
                       withIntermediateDirectories:YES
                                        attributes:attr
                                             error:&error];
                    if (error)
                        [HSupport showError:[NSString stringWithFormat:@"Error creating directory path: %@", [error localizedDescription]]];
                }
            }
            //..и сохряняем загруженный файл
            [data writeToFile:[DOCSFOLDER stringByAppendingString:fbfile.fileName] atomically:YES];
            loadersCounter--;
            if (loadersCounter == 0) {
                [HSupport hideLoader];
            }

        });
    });
}
+ (void) loadFromURL: (FBFile*)fbfile  {
    //    NSURL *url = [NSURL URLWithString:@"http://pharm.melodrom.ru/shares/default/files/1_Дитейлинг/Gaviscon/KM-1/КМ-1 март-апр'14. Гевискон.zip"];
    //loadersCounter++;
    NSArray *splitHTTPS = [fbfile.fileUrl componentsSeparatedByString:@"https://"];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"https://Admin:3huaaJ74vw5wGFnZPxq7@%@", splitHTTPS[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    NSDictionary *uInfo = [NSDictionary dictionaryWithObject:fbfile.fileName forKey:@"fileName"];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"fileLoaded" object:self userInfo:uInfo];
    NSData * data = [NSData dataWithContentsOfURL:url];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //выпиливаем подкаталоги из урла, чтобы потом их создать их в /Documents/
    NSArray *splitPath = [[NSArray alloc] initWithArray:[fbfile.fileLocalPath componentsSeparatedByCharactersInSet:[NSCharacterSet  characterSetWithCharactersInString:@"/"]]];
    NSString *storePath = DOCSFOLDER;
    //создаем каталоги, если есть необходимость
    for (int i=0; i<[splitPath count]-1; i++) {
        storePath = [storePath stringByAppendingString:splitPath[i]];
        BOOL isDir=NO;
        [[NSFileManager defaultManager] fileExistsAtPath:storePath isDirectory:&isDir];
        if (!isDir) {
            NSError *error = nil;
            NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                             forKey:NSFileProtectionKey];
            [[NSFileManager defaultManager] createDirectoryAtPath:storePath
                                      withIntermediateDirectories:YES
                                                       attributes:attr
                                                            error:&error];
            if (error)
                [HSupport showError:[NSString stringWithFormat:@"Error creating directory path: %@", [error localizedDescription]]];
        }
    }
    //..и сохряняем загруженный файл
    [data writeToFile:[DOCSFOLDER stringByAppendingString:fbfile.fileName] atomically:YES];
    //loadersCounter--;
    //if (loadersCounter == 0) {
    //    [HSupport hideLoader];
    //}
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"progress - %d",data.length);
    
    // Actual progress is self.receivedBytes / self.totalBytes
}

+ (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@",connection.currentRequest.URL.lastPathComponent);
}


@end

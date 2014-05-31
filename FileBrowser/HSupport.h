//
//  HSupport.h
//  Giftee-Partner
//
//  Created by Viktor Kumanenkov on 24.03.14.
//  Copyright (c) 2014 Giftee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBFile.h"

@interface HSupport : NSObject <NSURLConnectionDataDelegate>
+(BOOL) isIOS7;
+(BOOL) isEmailValid:(NSString*)email;
+(void) showMessage:(NSString*)messageText;
+(void) showError:(NSString*)messageText;
+(void) showLoader;
+(void) hideLoader;
+(void) showLoaderWithDelegate:(id)delegate;
+(NSData*) loadImage:(NSString*)imageURL;
+(void) setNavigationTitleColor:(UIColor*)color;
+ (UIImage*) imageWithColor:(UIColor*)color size:(CGSize)size;
+ (void) loadFromURL: (FBFile*)fbfile;
@end

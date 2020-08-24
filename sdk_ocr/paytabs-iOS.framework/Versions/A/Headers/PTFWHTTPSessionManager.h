//
//  PTFWHTTPSessionManager.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface PTFWHTTPSessionManager : AFHTTPSessionManager

+ (nonnull instancetype)sharedNoUserSession;
+ (nonnull instancetype)sharedNoUserHTMLBasedSession;

+ (nonnull instancetype)sharedUserSession;

+ (void)clearSession;

@end

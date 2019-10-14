//
//  NSError+Helpers.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Helpers)

+ (void)showErrorMessageWithError:(NSError *)error andInView:(UIViewController *)viewController;

@end

//
//  UIActivityViewController+Helpers.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActivityViewController (Helpers)

+ (void)showActivityViewControllerInViewController:(UIViewController *)viewController andWithSharingURLString:(NSString *)urlString andWithSharingContent:(NSString *)contentString;

@end

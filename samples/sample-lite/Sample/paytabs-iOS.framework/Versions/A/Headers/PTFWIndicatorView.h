//
//  PTFWIndicatorView.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

@interface PTFWIndicatorView : NSObject

#pragma mark - Static methods

+ (void)initializeActivityIndicatorInViewInBundle: (NSBundle *)bundle;
+ (PTFWActivityIndicatorViewController *)getIndicatorView;
+ (void)showActivityIndicator;
+ (void)hideActivityIndicator;


@end


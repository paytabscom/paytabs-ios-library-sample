//
//  PTFWWebView.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/23/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTFWWebView : UIView<UITextFieldDelegate>

#pragma mark - IBOutlets
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backWhiteButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backBlackButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *mbmeHeaderImageView;

@property (weak, nonatomic, nullable) IBOutlet UIWebView *webView;

@property (weak, nonatomic, nullable) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic, nullable) IBOutlet UIView *genericSDKFooterView;
@property (weak, nonatomic, nullable) IBOutlet UIView *mbmeSDKFooterView;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarContentTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *contentViewTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarHeightConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *inputViewHeightConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerHeightConstraint;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerContentBottomConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *mbmeFooterContentBottomConstraint;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *leadingContentConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *trailingContentConstraint;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didPressBackButtonCallback)(void);

@end


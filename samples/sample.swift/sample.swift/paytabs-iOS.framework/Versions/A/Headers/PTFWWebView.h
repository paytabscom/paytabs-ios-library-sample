//
//  PTFWWebView.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/23/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface PTFWWebView : UIView<UITextFieldDelegate>

#pragma mark - IBOutlets
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backWhiteButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backBlackButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *mbmeHeaderImageView;
@property (weak, nonatomic, nullable) IBOutlet UIView *webViewParent;

@property WKWebView * _Nullable webView;

@property (weak, nonatomic, nullable) IBOutlet UIView *navigationBarView;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarContentTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *contentViewTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarHeightConstaint;


@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *leadingContentConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *trailingContentConstraint;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didPressBackButtonCallback)(void);

@end


//
//  PTFWInitialSetupView.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/5/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTFWInitialSetupView : UIView

#pragma mark - IBOutlets
@property (weak, nonatomic, nullable) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *pleaseWaitLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *poweredByLabel;

@property (weak, nonatomic, nullable) IBOutlet UIImageView *backWhiteButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backBlackButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *mbmeHeaderImageView;

@property (weak, nonatomic, nullable) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (weak, nonatomic, nullable) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic, nullable) IBOutlet UIView *genericSDKFooterView;
@property (weak, nonatomic, nullable) IBOutlet UIView *mbmeSDKFooterView;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarHeightConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *inputViewHeightConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerHeightConstraint;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarContentTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *contentViewTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *pleaseWaitLabelTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerContentBottomConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *mbmeFooterContentBottomConstraint;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *leadingContentConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *trailingContentConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *leadingBodyConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *trailingBodyConstraint;


#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didPressBackButtonCallback)(void);

@end


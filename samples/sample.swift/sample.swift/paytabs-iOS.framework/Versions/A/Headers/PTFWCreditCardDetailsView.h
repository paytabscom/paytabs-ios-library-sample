//
//  PTFWCreditCardDetailsView.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/16/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTFWCreditCardDetailsView : UIView

#pragma mark - IBOutlets

@property (weak, nonatomic, nullable) IBOutlet UILabel *navigationBarTitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *cardholderNameHeaderLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *cardNumberHeaderLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *expiryDateHeaderLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *cvvHeaderLabel;

@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardNumberTextfield;
@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardHolderNameTextfield;
@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardCVVTextfield;

@property (weak, nonatomic, nullable) IBOutlet UIButton *cameraCloseButton;
@property (weak, nonatomic, nullable) IBOutlet UIButton *expiryMonthButton;
@property (weak, nonatomic, nullable) IBOutlet UIButton *expiryYearButton;
@property (weak, nonatomic, nullable) IBOutlet UIButton *payNowButton;

@property (weak, nonatomic, nullable) IBOutlet UIImageView *backWhiteButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backBlackButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *cameraButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *cameraCloseButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *creditCardTypeIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *mbmeHeaderImageView;

@property (weak, nonatomic, nullable) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic, nullable) IBOutlet UIView *formShadowView;
@property (weak, nonatomic, nullable) IBOutlet UIView *creditCardHoldernameBackgroundView;
@property (weak, nonatomic, nullable) IBOutlet UIView *creditCardNumberBackgroundView;
@property (weak, nonatomic, nullable) IBOutlet UIView *creditCardCVVBackgroundView;
@property (weak, nonatomic, nullable) IBOutlet UIView *creditCardnumberView;
@property (weak, nonatomic, nullable) IBOutlet UIView *creditCardScannerView;
@property (weak, nonatomic, nullable) IBOutlet UIView *genericSDKFooterView;
@property (weak, nonatomic, nullable) IBOutlet UIView *mbmeSDKFooterView;

@property (weak, nonatomic, nullable) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarHeightConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *inputViewHeightConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerHeightConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *navigationBarContentTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *contentViewTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *amountLabelTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *nameLabelTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *payNowTopConstaint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerContentBottomConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *mbmeFooterContentBottomConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *footerBottomSpaceConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *mbmeFooterBottomSpaceConstraint;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *leadingContentConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *trailingContentConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *leadingFormConstraint;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *trailingFormConstraint;


#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didPressBackButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didPressCameraButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didPressCameraCloseButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didPressExpiryMonthButtonCallback)(id sender);
@property (nonatomic, copy, nullable) void(^didPressExpiryYearButtonCallback)(id sender);
@property (nonatomic, copy, nullable) void(^didPressPayNowButtonCallback)(void);

@end


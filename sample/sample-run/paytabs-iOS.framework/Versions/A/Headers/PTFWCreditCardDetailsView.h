//
//  PTFWCreditCardDetailsView.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/16/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTFWCreditCardDetailsView : UIView<UITextFieldDelegate>

#pragma mark - IBOutlets
//@property (weak, nonatomic, nullable) IBOutlet UILabel *storeNameLabel;
//@property (weak, nonatomic, nullable) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *navigationBarTitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *allFieldsNoteLabel;

@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardNumberTextfield;
@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardHolderNameTextfield;
//@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardExpiryDateTextfield;
@property (weak, nonatomic, nullable) IBOutlet UITextField *creditCardCVVTextfield;

@property (weak, nonatomic, nullable) IBOutlet UIButton *expiryMonthButton;
@property (weak, nonatomic, nullable) IBOutlet UIButton *expiryYearButton;
@property (weak, nonatomic, nullable) IBOutlet UIButton *payNowButton;

@property (weak, nonatomic, nullable) IBOutlet UIImageView *backWhiteButtonIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *backBlackButtonIcon;

@property (weak, nonatomic, nullable) IBOutlet UIView *navigationBarView;

@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *bottomViewConstraint;

//@property (weak, nonatomic, nullable) IBOutlet UIImageView *storeImageView;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didPressBackButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didPressExpiryMonthButtonCallback)(id sender);
@property (nonatomic, copy, nullable) void(^didPressExpiryYearButtonCallback)(id sender);
@property (nonatomic, copy, nullable) void(^didPressPayNowButtonCallback)(void);

@end


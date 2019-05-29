//
//  PTFWFinishTransactionView.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/25/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTFWFinishTransactionView : UIView<UITextFieldDelegate>

#pragma mark - IBOutlets
@property (weak, nonatomic, nullable) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *transactionStateLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *transactionMessageLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *transactionIDLabel;

@property (weak, nonatomic, nullable) IBOutlet UIButton *continueButton;

@property (weak, nonatomic, nullable) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *successfulTransactionStateIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *unsuccessfulTransactionStateIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *paytabsWhiteNavigationIcon;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *paytabsBlackNavigationIcon;

@property (weak, nonatomic, nullable) IBOutlet UIView *navigationBarView;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didPressContinueButtonCallback)(void);

@end


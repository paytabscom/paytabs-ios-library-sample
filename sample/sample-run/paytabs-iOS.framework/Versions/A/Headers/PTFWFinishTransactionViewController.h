//
//  PTFWFinishTransactionViewController.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/25/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTFWFinishTransactionView;
@class PTFWResponsePrepareTransaction;
@class PTFWResponse3DSecureCardVerification;

@interface PTFWFinishTransactionViewController : UIViewController

#pragma mark - Init methods
- (nonnull instancetype)initWithNibName: (nonnull NSString *)nibNameOrNil
                                 bundle: (NSBundle *_Nullable)nibBundleOrNil
                       andWithViewFrame: (CGRect)viewFrame
                     andWithTransaction: (nonnull PTFWResponsePrepareTransaction *)transactionObject
                    andWithMerchantInfo: (nonnull PTFWResponseFetchMerchantInfo *)merchantInfoObject
                     andIs3DTransaction: (BOOL)is3DTransaction
                         andSDKLanguage: (nonnull NSString *)language;

#pragma mark - IBOutlets
@property (nonatomic, weak, nullable, readonly) IBOutlet PTFWFinishTransactionView *finishTransactionView;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didReceiveContinueButtonCallback)(int responseCode, NSString *__nonnull result, int transactionID, NSString *__nonnull tokenizedCustomerEmail, NSString *__nonnull tokenizedCustomerPassword, NSString *__nonnull token, BOOL isSuccessfulTransaction);

@end


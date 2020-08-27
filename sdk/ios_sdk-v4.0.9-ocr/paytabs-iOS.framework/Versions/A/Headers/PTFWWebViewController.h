//
//  PTFWWebViewController.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/23/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTFWWebView;
@class PTFWResponsePrepareTransaction;

typedef NS_ENUM(NSInteger, PTFWPaymentProcessor) {
    MPGS,
    MIGS,
    Cybersource
};

@interface PTFWWebViewController : UIViewController

#pragma mark - Init methods
- (nonnull instancetype)initWithNibName:  (nonnull NSString *)nibNameOrNil
                                 bundle: (NSBundle *_Nullable)nibBundleOrNil
                       andWithViewFrame: (CGRect)viewFrame
                     andWithTransaction: (nonnull PTFWResponsePrepareTransaction *)prepareTransactionObject
                    andWithMerchantInfo: (nonnull PTFWResponseFetchMerchantInfo *)merchantInfoObject
                    andPaymentProcessor: (PTFWPaymentProcessor)paymentProcessor
                         andSDKLanguage: (nonnull NSString *)language;

#pragma mark - IBOutlets
@property (nonatomic, weak, nullable, readonly) IBOutlet PTFWWebView *webRootView;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didReceiveBackButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didReceiveBackendNetworkFailureCallback)(void);
@property (nonatomic, copy, nullable) void(^didReceiveCloseFromFinishTransactionCallback)(int responseCode, NSString *__nonnull result, int transactionID, NSString *__nonnull tokenizedCustomerEmail, NSString *__nonnull tokenizedCustomerPassword, NSString *__nonnull token, BOOL transactionState);

@end


//
//  PTFWInitialSetupViewController.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/5/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTFWInitialSetupView;

@interface PTFWInitialSetupViewController : UIViewController

#pragma mark - Init methods
- (nonnull instancetype)initWithNibName: (nonnull NSString *)nibNameOrNil
                                 bundle: (NSBundle *_Nullable)nibBundleOrNil
                       andWithViewFrame: (CGRect)viewFrame
                          andWithAmount: (float)amount
                   andWithCustomerTitle: (nonnull NSString *)customerTitle
                    andWithCurrencyCode: (nonnull NSString *)currencyCode
                       andWithTaxAmount: (float)taxAmount
                     andWithSDKLanguage: (nonnull NSString *)sdkLanguage
                 andWithShippingAddress: (nonnull NSString *)shippingAddress
                    andWithShippingCity: (nonnull NSString *)shippingCity
                 andWithShippingCountry: (nonnull NSString *)shippingCountry
                   andWithShippingState: (nonnull NSString *)shippingState
                 andWithShippingZIPCode: (nonnull NSString *)shippingZIPCode
                  andWithBillingAddress: (nonnull NSString *)billingAddress
                     andWithBillingCity: (nonnull NSString *)billingCity
                  andWithBillingCountry: (nonnull NSString *)billingCountry
                    andWithBillingState: (nonnull NSString *)billingState
                  andWithBillingZIPCode: (nonnull NSString *)billingZIPCode
                         andWithOrderID: (nonnull NSString *)orderID
                     andWithPhoneNumber: (nonnull NSString *)phoneNumber
                   andWithCustomerEmail: (nonnull NSString *)customerEmail
                      andIsTokenization: (BOOL)isTokenization
                   andWithMerchantEmail: (nonnull NSString *)merchantEmail
               andWithMerchantSecretKey: (nonnull NSString *)merchantSecretKey
                    andWithAssigneeCode: (nonnull NSString *)assigneeCode
                      andWithThemeColor: (nonnull UIColor *)themeColor
                   andIsThemeColorLight: (BOOL)isThemeLight;
;

#pragma mark - IBOutlets
@property (nonatomic, weak, nullable, readonly) IBOutlet PTFWInitialSetupView *initialSetupView;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didReceiveBackButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didReceiveFinishTransactionCallback)(int responseCode, NSString *__nonnull result, int transactionID, NSString *__nonnull tokenizedCustomerEmail, NSString *__nonnull tokenizedCustomerPassword, NSString *__nonnull token, BOOL transactionState);

@end


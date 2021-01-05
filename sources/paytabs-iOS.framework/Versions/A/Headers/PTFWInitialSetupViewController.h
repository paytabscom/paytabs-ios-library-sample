//
//  PTFWInitialSetupViewController.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/5/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>

@class PTFWInitialSetupViewController;

@interface PTFWInitialSetupViewController : UIViewController<PKPaymentAuthorizationViewControllerDelegate>

#pragma mark - Init methods

// Intialize Paytabs Payment Page
- (nonnull instancetype)initWithBundle: (NSBundle *_Nullable)nibBundleOrNil
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
                          andIsPreAuth: (BOOL)isPreAuth
                  andWithMerchantEmail: (nonnull NSString *)merchantEmail
              andWithMerchantSecretKey: (nonnull NSString *)merchantSecretKey
               andWithMerchantRegion: (nonnull NSString *)merchantRegion
                   andWithAssigneeCode: (nonnull NSString *)assigneeCode
                     andWithThemeColor: (nonnull UIColor *)themeColor
                  andIsThemeColorLight: (BOOL)isThemeLight;

- (nonnull instancetype)initWithBundle: (NSBundle *_Nullable)nibBundleOrNil
                       andWithViewFrame: (CGRect)viewFrame
                          andWithAmount: (float)amount
                   andWithCustomerTitle: (nonnull NSString *)customerTitle
                    andWithCurrencyCode: (nonnull NSString *)currencyCode
                       andWithTaxAmount: (float)taxAmount
                     andWithSDKLanguage: (nonnull NSString *)sdkLanguage
                  andWithBillingAddress: (nonnull NSString *)billingAddress
                     andWithBillingCity: (nonnull NSString *)billingCity
                  andWithBillingCountry: (nonnull NSString *)billingCountry
                    andWithBillingState: (nonnull NSString *)billingState
                  andWithBillingZIPCode: (nonnull NSString *)billingZIPCode
                         andWithOrderID: (nonnull NSString *)orderID
                     andWithPhoneNumber: (nonnull NSString *)phoneNumber
                   andWithCustomerEmail: (nonnull NSString *)customerEmail
                      andIsTokenization: (BOOL)isTokenization
                           andIsPreAuth: (BOOL)isPreAuth
                   andWithMerchantEmail: (nonnull NSString *)merchantEmail
               andWithMerchantSecretKey: (nonnull NSString *)merchantSecretKey
                andWithMerchantRegion: (nonnull NSString *)merchantRegion
                    andWithAssigneeCode: (nonnull NSString *)assigneeCode
                      andWithThemeColor: (nonnull UIColor *)themeColor
                  andIsThemeColorLight: (BOOL)isThemeLight;

// Intialize Apple Pay bottomsheet
- (nonnull instancetype)initApplePayWithBundle:(NSBundle *_Nullable)nibBundleOrNil
                              andWithViewFrame:(CGRect)viewFrame
                                 andWithAmount:(float)amount
                          andWithCustomerTitle:(nonnull NSString *)customerTitle
                           andWithCurrencyCode:(nonnull NSString *)currencyCode
                            andWithCountryCode:(nonnull NSString *)countryCode
                          andForceShippingInfo:(BOOL) forceShippingInfo
                            andWithSDKLanguage:(nonnull NSString *)sdkLanguage
                                andWithOrderID:(nonnull NSString *)orderID
                             andIsTokenization:(BOOL)isTokenization
                                  andIsPreAuth:(BOOL)isPreAuth
                          andWithMerchantEmail:(nonnull NSString *)merchantEmail
                      andWithMerchantSecretKey:(nonnull NSString *)merchantSecretKey
             andWithMerchantApplePayIdentifier:(nonnull NSString *)merchantApplePayIdentifier andWithSupportedNetworks:(nonnull NSArray<PKPaymentNetwork> *) supportedNetworks
                    andWithMerchantRegion: (nonnull NSString *)merchantRegion
                           andWithAssigneeCode:(nonnull NSString *) assigneeCode;
#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didReceiveBackButtonCallback)(void);
@property (nonatomic, copy, nullable) void(^didReceiveFinishTransactionCallback)(int responseCode, NSString *__nonnull result, int transactionID, NSString *__nonnull tokenizedCustomerEmail, NSString *__nonnull tokenizedCustomerPassword, NSString *__nonnull token, BOOL transactionState, NSString *__nonnull statementReference, NSString *__nonnull traceCode);

// Callback when starting prepare payment page ( Can be used for loader or analytics)
@property (nonatomic, copy, nullable) void(^didStartPreparePaymentPage)(void);

// Callback when payment page is ready or fail ( Can be used for loader or analytics)
@property (nonatomic, copy, nullable) void(^didFinishPreparePaymentPage)(void);

@end


//
//  PTFWCreditCardDetailsHandler.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/16/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <BIObjCHelpers/BIObjCHelpers.h>

@class PTFWResponsePrepareTransaction;

@interface PTFWCreditCardDetailsHandler : BIHandlerBase

#pragma mark - Init Methods
- (nonnull instancetype)initWithViewController:(nonnull PTFWCreditCardDetailsViewController *)view;

#pragma mark - Public Methods
#pragma mark - Remote
- (void)doSendPrepareTransactionRequestWithSecretKey: (nonnull NSString *)secretKey
                                andWithMerchantEmail: (nonnull NSString *)merchantEmail
                                andWithMerchantTitle: (nonnull NSString *)merchantTitle
                               andWithCardExpiryDate: (nonnull NSString *)cardExpiryDate
                                      andWithCardCVV: (nonnull NSString *)cardCVV
                                   andWithCardNumber: (nonnull NSString *)cardNumber
                          andWithCardholderFirstName: (nonnull NSString *)cardholderFirstName
                           andWithCardholderLastName: (nonnull NSString *)cardholderLastName
                                 andWithCurrencyCode: (nonnull NSString *)currencyCode
                                      andWithOrderID: (nonnull NSString *)orderID
                                  andWithProductName: (nonnull NSString *)productName
                                andWithCustomerEmail: (nonnull NSString *)customerEmail
                                  andWithPhoneNumber: (nonnull NSString *)phoneNumber
                               andWithBillingAddress: (nonnull NSString *)billingAddress
                                  andWithBillingCity: (nonnull NSString *)billingCity
                               andWithBillingCountry: (nonnull NSString *)billingCountry
                                 andWithBillingState: (nonnull NSString *)billingState
                               andWithBillingZIPCode: (nonnull NSString *)billingZIPCode
                              andWithShippingAddress: (nonnull NSString *)shippingAddress
                                 andWithShippingCity: (nonnull NSString *)shippingCity
                              andWithShippingCountry: (nonnull NSString *)shippingCountry
                                andWithShippingState: (nonnull NSString *)shippingState
                              andWithShippingZIPCode: (nonnull NSString *)shippingZIPCode
                                 andWithPayTabsToken: (nonnull NSString *)paytabsToken
                             andWithCustomerPassword: (nonnull NSString *)customerPassword
                            andWithTransactionAmount: (float)amount
                                    andWithTaxAmount: (float)taxAmount
                               andWithDiscountAmount: (float)discountAmount
                              andWithTransactionRate: (float)transactionExchangeRate
                                   andIsTokenization: (BOOL)isTokenization
                               andIsExistingCustomer: (BOOL)isExistingCustomer;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didFinishPrepareTransactionSuccessfullyCallback)(PTFWResponsePrepareTransaction *__nonnull responseObject);
@property (nonatomic, copy, nullable) void(^didFinishWithErrorCallback)(NSError *__nonnull error);

@end


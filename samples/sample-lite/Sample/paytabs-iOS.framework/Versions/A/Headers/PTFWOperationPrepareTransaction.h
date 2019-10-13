//
//  PTFWOperationPrepareTransaction.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 15/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "PTFWNetworkOperationBase.h"

@class PTFWResponsePrepareTransaction;

@interface PTFWOperationPrepareTransaction : PTFWNetworkOperationBase

#pragma mark - Properties
@property (nonatomic, copy, nullable) NSString *secretKey;
@property (nonatomic, copy, nullable) NSString *merchantEmail;
@property (nonatomic, copy, nullable) NSString *merchantTitle;
@property (nonatomic, copy, nullable) NSString *cardExpiryDate;
@property (nonatomic, copy, nullable) NSString *cardCVV;
@property (nonatomic, copy, nullable) NSString *cardNumber;
@property (nonatomic, copy, nullable) NSString *cardholderFirstName;
@property (nonatomic, copy, nullable) NSString *cardholderLastName;
@property (nonatomic, copy, nullable) NSString *currencyCode;
@property (nonatomic, assign) float amount;
@property (nonatomic, assign) float taxAmount;
@property (nonatomic, assign) float discountAmount;
@property (nonatomic, copy, nullable) NSString *orderID;
@property (nonatomic, copy, nullable) NSString *productName;
@property (nonatomic, copy, nullable) NSString *customerEmail;
@property (nonatomic, copy, nullable) NSString *phoneNumber;
@property (nonatomic, copy, nullable) NSString *billingCountry;
@property (nonatomic, copy, nullable) NSString *shippingCountry;
@property (nonatomic, copy, nullable) NSString *billingAddress;
@property (nonatomic, copy, nullable) NSString *shippingAddress;
@property (nonatomic, copy, nullable) NSString *billingCity;
@property (nonatomic, copy, nullable) NSString *shippingCity;
@property (nonatomic, copy, nullable) NSString *billingZIPCode;
@property (nonatomic, copy, nullable) NSString *shippingZIPCode;
@property (nonatomic, copy, nullable) NSString *billingState;
@property (nonatomic, copy, nullable) NSString *shippingState;
@property (nonatomic, copy, nullable) NSString *paytabsToken;
@property (nonatomic, copy, nullable) NSString *customerPassword;
@property (nonatomic, assign) float transactionExchangeRate;
@property (nonatomic, assign) BOOL isTokenization;
@property (nonatomic, assign) BOOL isExistingCustomer;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didFinishSuccessfullyCallback)(PTFWResponsePrepareTransaction *__nonnull responseObject);

@end

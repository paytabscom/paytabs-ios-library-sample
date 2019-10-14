//
//  PTFWOperationPrepareTransactionApplePay.h
//  paytabs-iOS
//
//  Created by Ramy Sabry on 8/27/19.
//  Copyright © 2019 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTFWOperationPrepareTransactionApplePay;

@interface PTFWOperationPrepareTransactionApplePay : PTFWNetworkOperationBase

#pragma mark - Properties
@property (nonatomic, copy, nullable) NSString *secretKey;
@property (nonatomic, copy, nullable) NSString *merchantEmail;
@property (nonatomic, copy, nullable) NSString *merchantTitle;
@property (nonatomic, copy, nullable) NSString *currencyCode;
@property (nonatomic, assign) float amount;
@property (nonatomic, copy, nullable) NSString *orderID;
@property (nonatomic, copy, nullable) NSString *productName;
@property (nonatomic, assign) float transactionExchangeRate;
@property (nonatomic, assign) BOOL isTokenization;
@property (nonatomic, copy, nullable) NSString *applePayData;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didFinishSuccessfullyCallback)(PTFWResponsePrepareTransaction *__nonnull responseObject);
@end

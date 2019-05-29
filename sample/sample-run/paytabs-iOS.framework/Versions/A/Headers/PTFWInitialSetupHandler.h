//
//  PTFWInitialSetupHandler.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <BIObjCHelpers/BIObjCHelpers.h>


@class PTFWResponseSecretKeyValidation;
@class PTFWResponseFetchMerchantInfo;

@interface PTFWInitialSetupHandler : BIHandlerBase

#pragma mark - Init Methods
- (nonnull instancetype)initWithViewController:(nonnull PTFWInitialSetupViewController *)view;

#pragma mark - Public Methods
#pragma mark - Remote
- (void)doSendSecretKeyValidationRequestWithSecretKey:(nonnull NSString *)secretKey andWithMerchantEmail:(nonnull NSString *)merchantEmail;
- (void)doSendFetchMerchantInfoRequestWithSecretKey:(nonnull NSString *)secretKey andWithMerchantEmail:(nonnull NSString *)merchantEmail andWithCurrencyCode:(nonnull NSString *)currencyCode andWithAmount:(float)amount andIsTokenization:(BOOL)isTokenization andIsExistingCustomer:(BOOL)isExistingCustomer andWithPayTabsToken:(nonnull NSString *)paytabsToken andWithCustomerEmail:(nonnull NSString *)customerEmail andWithCustomerPassword:(nonnull NSString *)customerPassword;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didFinishSecretKeyValidationSuccessfullyCallback)(PTFWResponseSecretKeyValidation *__nonnull responseObject);
@property (nonatomic, copy, nullable) void(^didFinishMerchantInfoSuccessfullyCallback)(PTFWResponseFetchMerchantInfo *__nonnull responseObject);
@property (nonatomic, copy, nullable) void(^didFinishWithErrorCallback)(NSError *__nonnull error);

@end

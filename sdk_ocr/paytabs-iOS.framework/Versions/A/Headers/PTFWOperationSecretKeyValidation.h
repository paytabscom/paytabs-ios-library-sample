//
//  PTFWOperationSecretKeyValidation.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "PTFWNetworkOperationBase.h"

@class PTFWResponseSecretKeyValidation;

@interface PTFWOperationSecretKeyValidation : PTFWNetworkOperationBase

#pragma mark - Properties
@property (nonatomic, copy, nullable) NSString *secretKey;
@property (nonatomic, copy, nullable) NSString *merchantEmail;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didFinishSuccessfullyCallback)(PTFWResponseSecretKeyValidation *__nonnull responseObject);

@end

//
//  PTFWNetworkOperationBase+Subclassing.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "PTFWNetworkOperationBase.h"

@interface PTFWNetworkOperationBase (Subclassing)

@property (nonatomic, strong, nullable, readwrite) NSURLSessionDataTask *networkTask;

- (void)handleDidFinishedWithResponse:(nonnull id)response;
- (void)handleDidFinishedUpdatingVoucherWithResponse:(nonnull id)response;

- (void)handleDidFinishedWithError:(nonnull NSError *)error;
- (void)handleDidFinishedCommon;

- (void)safeCallDidFinishWithErrorCallback:(nonnull NSError *)error;
- (void)safeCallDidFinishSuccessfullyCallback:(nonnull id)responseObject;

@end

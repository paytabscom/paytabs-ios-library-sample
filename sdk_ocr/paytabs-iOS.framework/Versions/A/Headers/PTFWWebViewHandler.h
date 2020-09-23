//
//  PTFWWebViewHandler.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/23/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <BIObjCHelpers/BIObjCHelpers.h>

@class PTFWWebViewController;
@class PTFWResponsePrepareTransaction;
@class PTFWResponse3DSecureCardVerification;

@interface PTFWWebViewHandler : BIHandlerBase

#pragma mark - Init Methods
- (instancetype)initWithViewController:(PTFWWebViewController *)view;

#pragma mark - Public Methods
#pragma mark - Local
- (NSMutableURLRequest *)getVISAMutableRequestWithTransactionObject:(PTFWResponsePrepareTransaction *)transactionObject;
- (NSMutableURLRequest *)getMIGSMutableRequestWithTransactionObject:(PTFWResponsePrepareTransaction *)transactionObject;
- (NSMutableURLRequest *)getMPGSMutableRequestWithTransactionObject:(PTFWResponsePrepareTransaction *)transactionObject;

- (PTFWResponsePrepareTransaction *)get3DSecureCardVerificationFromWebResponse:(NSString *)htmlString;

#pragma mark - Callbacks

@end


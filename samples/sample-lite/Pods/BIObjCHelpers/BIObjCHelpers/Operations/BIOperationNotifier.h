//
//  BIOperationNotifier.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 5/11/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <BIObjCHelpers/BIOperationBase.h>

#import <Foundation/Foundation.h>

@class BIOperationNotifier;

@protocol BIOperationNotifierListener <NSObject>

@optional
- (void)operation:(BIOperationNotifier *__nonnull)operation didFinishWithResponse:(id __nullable)response;
- (void)operation:(BIOperationNotifier *__nonnull)operation didFinishWithError:(NSError *__nullable)error;
- (void)operationDidFinishCommon:(BIOperationNotifier *__nonnull)operation;

@end

@interface BIOperationNotifier : BIOperationBase

- (void)registerOperationFinishedListener:(id<BIOperationNotifierListener> __nonnull)listener;
- (void)unregisterOperationFinishedListener:(id<BIOperationNotifierListener> __nonnull)listener;
- (void)removeAllListeners;

@end

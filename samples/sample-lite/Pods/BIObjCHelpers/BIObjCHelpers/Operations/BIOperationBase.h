//
//  BIOperationBase.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 5/31/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void dispatchCodeOnMainThread(void(^__nonnull codeBlock)(void));

@interface BIOperationBase : NSOperation

// NSOperation
@property (nonatomic, assign, readonly) BOOL isExecuting;
@property (nonatomic, assign, readonly) BOOL isFinished;

// Callbacks
@property (nonatomic, copy, nullable) void(^didFinishWithErrorCallback)(NSError *__nonnull error);
@property (nonatomic, copy, nullable) void(^didFinishSuccessfullyCallback)(id __nonnull responseObject);
@property (nonatomic, copy, nullable) void(^didFinishCommonCallback)(void);
@property (nonatomic, assign) BOOL runCallbacksOnMainThread;

// Handle operations response states
- (void)handleDidFinishedWithResponse:(nonnull id)response;
- (void)handleDidFinishedWithError:(nonnull NSError *)error;
- (void)handleDidFinishedCommon;
- (void)finish;

// Trigger callbacks
- (void)safeCallDidFinishWithErrorCallback:(nonnull NSError *)error;
- (void)safeCallDidFinishSuccessfullyCallback:(nonnull id)responseObject;
- (void)safeCallDidFinishCommon;

@end

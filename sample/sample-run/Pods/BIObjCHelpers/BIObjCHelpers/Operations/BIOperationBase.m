//
//  BIOperationBase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 5/31/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIOperationBase.h"

void dispatchCodeOnMainThread(void(^__nonnull codeBlock)()) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            codeBlock();
        });
    } else {
        codeBlock();
    }
}

@implementation BIOperationBase

#pragma mark - Init methods

- (nonnull instancetype)init {
    self = [super init];
    if (self) {
        self.runCallbacksOnMainThread = YES;
    }
    return self;
}

#pragma mark - NSOperation methods

- (void)start {
    dispatchCodeOnMainThread( ^{
        [self willChangeValueForKey:@"isExecuting"];
        _isExecuting = YES;
        [self didChangeValueForKey:@"isExecuting"];
    });
}

#pragma mark - Public methods

- (void)safeCallDidFinishWithErrorCallback:(nonnull NSError *)error {
    void(^block)() = ^{
        if (self.didFinishWithErrorCallback) {
            self.didFinishWithErrorCallback(error);
        }
        [self handleDidFinishedCommon];
    };
    if (self.runCallbacksOnMainThread) {
        dispatchCodeOnMainThread( ^{
            block();
        });
    } else {
        block();
    }
}

- (void)safeCallDidFinishSuccessfullyCallback:(nonnull id)responseObject {
    void(^block)() = ^{
        if (self.didFinishSuccessfullyCallback) {
            self.didFinishSuccessfullyCallback(responseObject);
        }
        [self handleDidFinishedCommon];
    };
    if (self.runCallbacksOnMainThread) {
        dispatchCodeOnMainThread( ^{
            block();
        });
    } else {
        block();
    }
}

- (void)safeCallDidFinishCommon {
    void(^block)() = ^{
        if (self.didFinishCommonCallback) {
            self.didFinishCommonCallback();
        }
    };
    if (self.runCallbacksOnMainThread) {
        dispatchCodeOnMainThread( ^{
            block();
        });
    } else {
        block();
    }
}

- (void)handleDidFinishedWithResponse:(id)response {
    [self safeCallDidFinishSuccessfullyCallback:response];
}

- (void)handleDidFinishedWithError:(NSError *)error {
    [self safeCallDidFinishWithErrorCallback:error];
}

- (void)handleDidFinishedCommon {
    [self safeCallDidFinishCommon];
    [self finish];
}

- (void)finish {
    dispatchCodeOnMainThread( ^{
        [self willChangeValueForKey:@"isExecuting"];
        [self willChangeValueForKey:@"isFinished"];
        _isExecuting = NO;
        _isFinished = YES;
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
    });
}

@end

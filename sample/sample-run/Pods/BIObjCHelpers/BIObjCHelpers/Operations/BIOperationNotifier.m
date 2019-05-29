//
//  BIOperationNotifier.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 5/11/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIOperationNotifier.h"

@interface BIOperationNotifier()

@property (nonatomic, strong, nullable, readwrite) NSHashTable <id<BIOperationNotifierListener>> *operationFinishedListeners;

@end

@implementation BIOperationNotifier

#pragma mark - Public methods

- (void)registerOperationFinishedListener:(id<BIOperationNotifierListener>)listener {
    [self.operationFinishedListeners addObject:listener];
}

- (void)unregisterOperationFinishedListener:(id<BIOperationNotifierListener>)listener {
    [self.operationFinishedListeners removeObject:listener];
}

- (void)removeAllListeners {
    [self.operationFinishedListeners removeAllObjects];
}

#pragma mark - BIOperationBase methods

- (void)safeCallDidFinishWithErrorCallback:(nonnull NSError *)error {
    void(^block)() = ^{
        [self BI_notifyOperationDidFinishWithError:error];
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
        [self BI_notifyOperationDidFinishWithResponse:responseObject];
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
        [self BI_notifyOperationDidFinishCommon];
    };
    if (self.runCallbacksOnMainThread) {
        dispatchCodeOnMainThread( ^{
            block();
        });
    } else {
        block();
    }
}

#pragma mark - Properties methods

- (NSHashTable<id<BIOperationNotifierListener>> *)operationFinishedListeners {
    if (!_operationFinishedListeners) {
        _operationFinishedListeners = [NSHashTable weakObjectsHashTable];
    }
    return _operationFinishedListeners;
}

#pragma mark - Private methods

- (void)BI_notifyOperationDidFinishWithResponse:(id __nullable)response {
    if (self.didFinishSuccessfullyCallback) {
        self.didFinishSuccessfullyCallback(response);
    }
    NSHashTable *copiedListeners = [self.operationFinishedListeners copy];
    for (id<BIOperationNotifierListener> listener in copiedListeners) {
        if ([listener respondsToSelector:@selector(operation:didFinishWithResponse:)]) {
            [listener operation:self didFinishWithResponse:response];
        }
    }
}

- (void)BI_notifyOperationDidFinishWithError:(NSError *__nullable)error {
    if (self.didFinishWithErrorCallback) {
        self.didFinishWithErrorCallback(error);
    }
    NSHashTable *copiedListeners = [self.operationFinishedListeners copy];
    for (id<BIOperationNotifierListener> listener in copiedListeners) {
        if ([listener respondsToSelector:@selector(operation:didFinishWithError:)]) {
            [listener operation:self didFinishWithError:error];
        }
    }
}

- (void)BI_notifyOperationDidFinishCommon {
    if (self.didFinishCommonCallback) {
        self.didFinishCommonCallback();
    }
    NSHashTable *copiedListeners = [self.operationFinishedListeners copy];
    for (id<BIOperationNotifierListener> listener in copiedListeners) {
        if ([listener respondsToSelector:@selector(operationDidFinishCommon:)]) {
            [listener operationDidFinishCommon:self];
        }
    }
}

@end

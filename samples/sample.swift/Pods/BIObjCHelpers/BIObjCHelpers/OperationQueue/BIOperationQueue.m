//
//  BIOperationQueue.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/2/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIOperationQueue.h"

@interface BIOperationQueue ()

@end

@implementation BIOperationQueue

#pragma mark - Constants

static void * kBIOperationQueueFinishedContext = &kBIOperationQueueFinishedContext;

#pragma mark - Dealloc

- (void)dealloc {
    [self unregisterListeners];
}

#pragma mark - Initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerListeners];
    }
    return self;
}

#pragma mark - NSOperationQueue methods

- (void)addOperation:(NSOperation *)operation {
    NSParameterAssert(operation);
    [super addOperation:operation];
}

- (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait {
    NSParameterAssert([ops count]);
    [super addOperations:ops waitUntilFinished:wait];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (context == kBIOperationQueueFinishedContext) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(operations))]) {
            if (![self.operations count]) {
                if (self.finishedCallback) {
                    self.finishedCallback();
                }
            }
        }
    }
}

#pragma mark - Private methods

- (void)registerListeners {
    
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(operations))
              options:NSKeyValueObservingOptionNew
              context:kBIOperationQueueFinishedContext];
}

- (void)unregisterListeners {
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(operations)) context:kBIOperationQueueFinishedContext];
}

@end

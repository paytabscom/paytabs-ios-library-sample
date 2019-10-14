//
//  BIDatasourceBase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"
#import "BIOperationBase.h"
#import "BIOperationNotifier.h"

@interface BIDatasourceBase ()

@property (nonatomic, strong, nonnull, readwrite) NSHashTable *operations;

@end


@implementation BIDatasourceBase

#pragma mark - Public methods

- (void)cancelAllCurrentOperations:(BOOL)silently {
    NSHashTable *copiedOperations = [self.operations copy];
    for (id object in copiedOperations) {
        if ([object isKindOfClass:[BIOperationBase class]]) {
            BIOperationBase *operation = (BIOperationBase *)object;
            if (silently) {
                operation.didFinishWithErrorCallback = nil;
                if ([operation isKindOfClass:[BIOperationNotifier class]]) {
                    BIOperationNotifier *notifierOperation = (BIOperationNotifier *)operation;
                    [notifierOperation removeAllListeners];
                }
            }
            [operation cancel];
        }
    }
    [self.operations removeAllObjects];
}

#pragma mark - Property methods

- (NSHashTable *)operations {
    if (!_operations) {
        _operations = [NSHashTable weakObjectsHashTable];
    }
    return _operations;
}

@end

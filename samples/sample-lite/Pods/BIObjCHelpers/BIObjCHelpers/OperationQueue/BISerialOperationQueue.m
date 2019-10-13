//
//  BISerialOperationQueue.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/3/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BISerialOperationQueue.h"

@implementation BISerialOperationQueue

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxConcurrentOperationCount = 1;
    }
    return self;
}

@end

//
//  BILifecycle.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BILifecycle.h"

@interface BILifecycle ()

@property (nonatomic, assign, readwrite, getter=isLoaded) BOOL loaded;

@end


@implementation BILifecycle

#pragma mark - Initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.loaded = NO;
    }
    return self;
}

#pragma mark - Public methods

- (void)load {
    self.loaded = YES;
}

- (void)unload {
    self.loaded = NO;
}

@end

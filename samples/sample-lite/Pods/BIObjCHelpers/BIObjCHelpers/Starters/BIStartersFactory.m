//
//  BIStartersFactory.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIStartersFactory.h"
#import "BIStarterProtocol.h"

@interface BIStartersFactory ()

@property (nonatomic, strong, nullable, readwrite) NSMutableArray *starters;

@end

@implementation BIStartersFactory

- (instancetype)init {
    self = [super init];
    if (self) {
        self.starters = [NSMutableArray array];
        [self loadStarters];
    }
    return self;
}

- (void)addStarter:(id<BIStarter>)starter {
    NSParameterAssert(starter);
    [self.starters addObject: starter];
}

- (void)loadStarters {
    // Should be overriden.
}

- (void)run {
    for (id<BIStarter> starter in self.starters) {
        [starter start];
    }
}

@end

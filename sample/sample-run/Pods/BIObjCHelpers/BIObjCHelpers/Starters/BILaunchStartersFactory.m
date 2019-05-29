//
//  BILaunchStartersFactory.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 10/13/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BILaunchStartersFactory.h"
#import "BIStarterProtocol.h"

@interface BILaunchStartersFactory ()

@property (nonatomic, strong, nonnull, readwrite) UIApplication *application;
@property (nonatomic, strong, nullable, readwrite) NSDictionary *launchOptions;

@end

@implementation BILaunchStartersFactory

#pragma mark - Init methods

- (nonnull instancetype)initWithLaunchingOptions:(NSDictionary *)launchOptions {
    self = [super init];
    if (self) {
        self.application = [UIApplication sharedApplication];
        self.launchOptions = launchOptions;
    }
    return self;
}

#pragma mark - BIStartersFactory methods

- (void)run {
    for (id<BIStarter> starter in self.starters) {
        if ([starter respondsToSelector:@selector(setLaunchOptions:)]) {
            [starter setLaunchOptions:self.launchOptions];
        }
        [starter start];
    }
}

@end

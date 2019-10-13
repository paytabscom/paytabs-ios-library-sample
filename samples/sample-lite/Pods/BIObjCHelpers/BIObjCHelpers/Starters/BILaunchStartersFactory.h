//
//  BILaunchStartersFactory.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 10/13/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BIStartersFactory.h"

#import <UIKit/UIKit.h>

@interface BILaunchStartersFactory : BIStartersFactory

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new  NS_UNAVAILABLE;

- (nonnull instancetype)initWithLaunchingOptions:(nullable NSDictionary *)launchOptions;

@property (nonatomic, strong, nonnull, readonly) UIApplication *application;
@property (nonatomic, strong, nonnull, readonly) NSDictionary *launchOptions;

@end

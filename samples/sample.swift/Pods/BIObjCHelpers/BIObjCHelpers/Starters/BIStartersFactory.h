//
//  BIStartersFactory.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BIStarter;

@interface BIStartersFactory : NSObject

@property (nonatomic, strong, nullable, readonly) NSMutableArray *starters;

- (void)run;
- (void)addStarter:(nonnull id<BIStarter>)starter;
- (void)loadStarters;

@end

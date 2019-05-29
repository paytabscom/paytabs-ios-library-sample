//
//  BILifecycle.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BILifecycle : NSObject

- (nonnull instancetype)init;

@property (nonatomic, assign, readonly, getter=isLoaded) BOOL loaded;

- (void)load;
- (void)unload;

@end

//
//  BIStarterProtocol.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BIStarter <NSObject>

@required
- (void)start;

@optional
@property (nonatomic, strong, nullable) NSDictionary *launchOptions;

@end

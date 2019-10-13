//
//  PTFWSessionListener.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

@class PTFWUserData;

@interface PTFWSessionListener : NSObject

@property (nonatomic, copy, nullable) void(^didLoginCallback)(PTFWUserData *__nonnull);
@property (nonatomic, copy, nullable) void(^didLogoutCallback)();

@end

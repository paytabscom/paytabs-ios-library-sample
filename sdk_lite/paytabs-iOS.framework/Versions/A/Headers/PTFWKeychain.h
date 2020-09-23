//
//  PTFWKeychain.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Lockbox/Lockbox.h>

extern const struct PTFWKeychainKeys {
    __unsafe_unretained NSString * __nonnull userToken;
    __unsafe_unretained NSString * __nonnull userObject;
} PTFWKeychainKeys;

@interface PTFWKeychain : Lockbox

#pragma mark - Init
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

+ (nonnull instancetype)sharedInstance;

#pragma mark - Properties
@property (nonatomic, copy, nullable, readonly) NSString *userToken;

#pragma mark - Public Methods
- (void)archiveUserToken:(nullable NSString *)token;
- (nullable NSString *)unarchiveToken;


@end

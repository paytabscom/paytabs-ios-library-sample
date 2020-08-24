//
//  PTFWUserData+Serialization.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "PTFWUserData.h"

@class PTFWUserDefaults;
@class PTFWKeychain;

@interface PTFWUserData (Serialization)

- (void)backupCurrentSessionUser;
+ (nullable instancetype)currentSessionUserFromBackup;

- (void)backupUserWithKey:(nonnull NSString *)key
             userDefaults:(nonnull PTFWUserDefaults *)userDefaults
                 keychain:(nonnull PTFWKeychain *)keychain;
+ (nullable instancetype)userFromBackupWithKey:(nonnull NSString *)key
                                  userDefaults:(nonnull PTFWUserDefaults *)userDefaults
                                      keychain:(nonnull PTFWKeychain *)keychain;

- (void)resetUserBackupForKey:(nonnull NSString *)key
                 userDefaults:(nonnull PTFWUserDefaults *)userDefaults
                     keychain:(nonnull PTFWKeychain *)keychain;

@end

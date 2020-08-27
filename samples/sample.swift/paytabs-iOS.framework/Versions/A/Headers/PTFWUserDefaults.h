//
//  PTFWUserDefaults.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct PTFWUserDefaultsKeys {
  __unsafe_unretained NSString * __nonnull deviceKey;
  __unsafe_unretained NSString * __nonnull deviceUDID;
  __unsafe_unretained NSString * __nonnull keychainPrefix;
} PTFWUserDefaultsKeys;


@interface PTFWUserDefaults : NSObject

+ (nonnull instancetype)sharedUserDefaults;

@property (nonatomic, strong, nonnull, readonly) NSUserDefaults *userDefaults;

@property (nonatomic, copy, nullable, readonly) NSString *deviceUDID;
@property (nonatomic, copy, nullable, readonly) NSString *deviceKey;
@property (nonatomic, copy, nonnull, readonly) NSString *keychainPrefix;

- (void)setRawUserData:(nullable NSDictionary *)rawData forKey:(nonnull NSString *)key;
- (nullable NSDictionary *)rawUserDataForKey:(nonnull NSString *)key;

@end

//
//  PTFWUserData.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

FOUNDATION_EXTERN const struct PTFWUserDataKeys {
    __unsafe_unretained NSString * __nonnull userID;
    __unsafe_unretained NSString * __nonnull email;
    __unsafe_unretained NSString * __nonnull firstName;
    __unsafe_unretained NSString * __nonnull lastName;
    __unsafe_unretained NSString * __nonnull profileImageURLString;
    __unsafe_unretained NSString * __nonnull coverImageURLString;
} PTFWUserDataKeys;


@class PTFWSessionManager;

@interface PTFWUserData : MTLModel <MTLJSONSerializing, NSCopying, NSMutableCopying>

@property (nonatomic, copy,   nonnull, readonly) NSString *name;
@property (nonatomic, copy,   nonnull, readonly) NSString *userID;
@property (nonatomic, copy,   nonnull, readonly) NSString *email;
@property (nonatomic, copy,   nonnull, readonly) NSString *firstName;
@property (nonatomic, copy,   nonnull, readonly) NSString *lastName;



// Images
@property (nonatomic, copy,   nullable, readonly) NSString *profileImageURLString;
@property (nonatomic, copy,   nullable, readonly) NSString *coverImageURLString;

@property (nonatomic, strong, nonnull, readonly) PTFWSessionManager *sessionManager;


@end


@interface PTFWMutableUserData : PTFWUserData

@property (nonatomic, copy,   nonnull, readwrite) NSString *email;
@property (nonatomic, copy,   nonnull, readwrite) NSString *password;
@property (nonatomic, copy,   nonnull, readwrite) NSString *firstName;
@property (nonatomic, copy,   nonnull, readwrite) NSString *lastName;

@end


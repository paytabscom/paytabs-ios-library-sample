//
//  PTFWSessionManager.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "PTFWSignUpTypeConstant.h"

@class PTFWUserData;
@class PTFWMutableUserData;
@class PTFWSessionListener;

@interface PTFWSessionManager : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

+ (nonnull instancetype)sharedInstance;

@property (nonatomic, strong, nullable, readonly) PTFWUserData *currentUser;
@property (nonatomic, strong, nullable, readonly) id<PTFWUserDataSourceProtocol> currentUserSource;

@property (nonatomic, assign, readonly, getter=isUserLoggedIn) BOOL userLoggedIn;

- (void)registerListener:(nonnull PTFWSessionListener *)listener;
- (void)unregisterListener:(nonnull PTFWSessionListener *)listener;

//- (void)loginWithUserEmail:(nonnull NSString *)email
//             facebookToken:(nonnull NSString *)facebookToken
//           completionBlock:(void(^__nullable)(BOOL successfull, NSError *__nullable error))completionBlock;

- (void)loadUserSessionFromBackupIfAvailable;

@end

// TODO: [Bogdan] Move this to testing target once we have login backend support
@interface PTFWSessionManager (Testing)

- (void)testLoginUser:(nonnull PTFWUserData *)user;
- (void)testLogout;

@end

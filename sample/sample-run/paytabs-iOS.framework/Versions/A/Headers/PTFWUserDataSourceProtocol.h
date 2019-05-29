//
//  PTFWUserDataSourceProtocol.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

@class PTFWUserData;

@protocol PTFWUserDataSourceProtocol <NSObject>

@property (nonatomic, copy, nonnull,  readonly) NSString *userID;
@property (nonatomic, copy, nullable, readonly) PTFWUserData *userData;
@property (nonatomic, assign, readonly, getter=isDataDownloaded) BOOL dataDownloaded;
@property (nonatomic, assign, readonly, getter=isCurrentUser) BOOL currentUser;

@end

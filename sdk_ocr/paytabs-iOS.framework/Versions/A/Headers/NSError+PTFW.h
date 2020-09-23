//
//  NSError+PTFW.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTFWNetworkConstants.h"

extern const struct PTFWErrorDomains {
    __unsafe_unretained NSString * __nonnull network;
    __unsafe_unretained NSString * __nonnull application;
} PTFWErrorDomains;

extern const struct PTFWErrorUserInfoKeys {
    __unsafe_unretained NSString * __nonnull title;
    __unsafe_unretained NSString * __nonnull description;
    __unsafe_unretained NSString * __nonnull backendStatusCode;
} PTFWErrorUserInfoKeys;

typedef NS_ENUM(NSInteger, PTFWNetworkErrorCodes) {
    PTFWNetworkErrorCodeGeneral = 3000,
    PTFWNetworkErrorCodeCanceled,
    PTFWNetworkErrorStatusCode
};

typedef NS_ENUM(NSInteger, PTFWApplicationErrorCodes) {
    PTFWApplicationErrorCodeGeneral = 4000,
    PTFWApplicationErrorCanceled
};

@interface NSError (NetworkErrors)

+ (nonnull instancetype)networkErrorGeneral;
+ (nonnull instancetype)networkErrorCanceled;
+ (nonnull instancetype)networkErrorNoInternet;
+ (nonnull instancetype)networkErrorCannotConnectToServer;
+ (nonnull instancetype)networkErrorCannotParseContent;

+ (nonnull instancetype)networkErrorWithStatusCode:(PTFWStatusCodes)statusCode;
+ (nonnull instancetype)networkErrorWithBackendStatusCode:(PTFWStatusCodes)statusCode
                                              description:(nonnull NSString *)description;

- (nonnull instancetype)convertToAppNetworkError;

@end

@interface NSError (ApplicationErrors)

+ (nonnull instancetype)appErrorWithCode:(PTFWApplicationErrorCodes)code
                                   title:(nonnull NSString *)title
                             description:(nonnull NSString *)description;

+ (nonnull instancetype)appErrorGeneralWithDescription:(nonnull NSString *)description;
+ (nonnull instancetype)appErrorCanceled;

@end


@interface NSError (DisplayError)

@property (nonatomic, copy, nullable, readonly) NSString *displayTitle;
@property (nonatomic, copy, nullable, readonly) NSString *displayDescription;
@property (nonatomic, assign, readonly) NSInteger backendStatusCode;

@end


@interface NSError (ErrorStrings)

+ (nonnull NSString *)errorGeneralTitleString;
+ (nonnull NSString *)networkErrorGeneralDescriptionString;
+ (nonnull NSString *)networkErrorGeneralCanceledString;
+ (nonnull NSString *)networkErrorNoInternetString;
+ (nonnull NSString *)networkErrorCannotConnectToServerString;
+ (nonnull NSString *)networkErrorCannotParseContentString;
+ (nonnull NSString *)networkErrorInvalidCredentialsString;
+ (nonnull NSString *)networkErrorInvalidEmailString;
+ (nonnull NSString *)networkErrorEmailInUseString;

@end

//
//  PTFWUtilities.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/11/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFWUtilities : NSObject

#pragma mark - Shared Instance
+ (PTFWUtilities *)sharedInstance;

#pragma mark - Public Methods
#pragma mark - Countries
- (BOOL)isCountryNameValidWith: (NSString *)countryName andWithBundle: (NSBundle *)bundle;

#pragma mark - Currencies
- (BOOL)isCurrencyCodeValidWith: (NSString *)currencyCode andWithBundle: (NSBundle *)bundle;

#pragma mark - Reason Code
- (NSString *)getReasonWithReasonCode: (int)reasonCode andWithBundle: (NSBundle *)bundle;

#pragma mark - Array
- (int)getIndexOf: (NSString *)value inArray: (NSArray *)array;

#pragma mark - Expiry
- (NSString *)getMonthCodeWithMonthName: (NSString *)monthName andInArray: (NSArray *)array;
- (NSString *)getYearCodeWithYearName: (NSString *)year;

#pragma mark - Timeout
- (void)setSDKInitiateTime;
- (NSString *)getSDKInitiateTime;

- (NSString *)getCurrentTime;
- (int)getSDKSecondsWhenInitiated;

- (void)setTotalTimeoutTimeWithSeconds: (int)seconds;
- (int)getTotalTimeoutTime;

#pragma mark - Pre Auth
- (void)setPreAuthFlagWithFlag: (BOOL)isPreAuth;
- (BOOL)getPreAuthFlag;

#pragma mark - SDK Language
- (void)setSDKLanguageWithLanguage: (NSString *)sdkLanguage;
- (NSString *)getSDKLanguage;

#pragma mark - Theme
- (void)setThemeColor: (UIColor *)themeColor;
- (UIColor *)getThemeColor;
- (void)setThemeColorType: (BOOL)isThemeLight;
- (int)getThemeColorType;

@end

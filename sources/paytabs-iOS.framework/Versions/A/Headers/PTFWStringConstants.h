//
//  PTFWStringConstants.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/5/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFWStringConstants : NSObject

#pragma mark - XIBs
extern NSString * const kInitialSetupXIBName;
extern NSString * const kCreditCardDetailsXIBName;
extern NSString * const kWebViewXIBName;
extern NSString * const kFinishTransactionViewXIBName;

#pragma mark - Interface filenames
extern NSString * const kEmptyCardIconName;
extern NSString * const kErrorCardIconName;
extern NSString * const kAmexCardIconName;
extern NSString * const kVisaCardIconName;
extern NSString * const kMastercardCardIconName;

#pragma mark - Resources filenames
extern NSString * const kMontserratBoldFontName;
extern NSString * const kMontserratMediumFontName;
extern NSString * const kMontserratLightFontName;

#pragma mark - Local datasource filenames
extern NSString * const kReasonCodePlistName;

#pragma mark - SDK Languages
extern NSString * const kEnglishSDKIdentifier;
extern NSString * const kArabicSDKIdentifier;

#pragma mark - URLs
extern NSString * const kImagesDatasourceURL;


#pragma mark - Keys
extern NSString * const kSDKInitiateTimeKey;
extern NSString * const kTotalTimeoutSecondsKey;
extern NSString * const kPreAuthFlagKey;
extern NSString * const kSDKLanguageKey;
extern NSString * const kIsTimeoutOccured;
extern NSString * const kThemeColor;
extern NSString * const kThemeColorType;
extern NSString * const kSDKFlagForMBMEKey;

#pragma mark - MBME
extern NSString * const kMBMEMerchantEmail;
extern NSString * const kMBMEMerchantSecretKey;

@end

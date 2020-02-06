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

#pragma mark - Messages
extern NSString * const kAlertTitle;
extern NSString * const kErrorTitle;
extern NSString * const kSuccessTitle;
extern NSString * const kDismissTitle;
extern NSString * const kInternetNotAvailable;
extern NSString * const kInternetNotAccessible;
extern NSString * const kAuthorizationFailed;
extern NSString * const kSomethingGoesWrong;
extern NSString * const kOperationTimedOut;
extern NSString * const kNetworkFailed;
extern NSString * const kCameraPermission;
extern NSString * const kArabicCameraPermission;

extern NSString * const kEmptyAmount;
extern NSString * const kEmptyCustomerTitle;
extern NSString * const kEmptyCurrencyCode;
extern NSString * const kEmptyTaxAmount;
extern NSString * const kEmptySDKLanguage;
extern NSString * const kEmptyShippingAddress;
extern NSString * const kEmptyShippingCity;
extern NSString * const kEmptyShippingCountry;
extern NSString * const kEmptyShippingState;
extern NSString * const kEmptyShippingZIPCode;
extern NSString * const kEmptyBillingAddress;
extern NSString * const kEmptyBillingCity;
extern NSString * const kEmptyBillingCountry;
extern NSString * const kEmptyBillingState;
extern NSString * const kEmptyBillingZIPCode;
extern NSString * const kEmptyOrderID;
extern NSString * const kEmptyPhoneNumber;
extern NSString * const kEmptyCustomerEmail;
extern NSString * const kEmptyCustomerPassword;
extern NSString * const kEmptyPaytabsToken;
extern NSString * const kEmptyMerchantEmail;
extern NSString * const kEmptyMerchantSecretKey;
extern NSString * const kEmptyAssigneeCode;
extern NSString * const kEmptyTimeoutSeconds;
extern NSString * const kInvalidCustomerEmail;
extern NSString * const kInvalidMerchantEmail;
extern NSString * const kInvalidShippingAddress;
extern NSString * const kInvalidShippingCity;
extern NSString * const kInvalidShippingCountry;
extern NSString * const kInvalidShippingState;
extern NSString * const kInvalidShippingZIPCode;
extern NSString * const kInvalidBillingAddress;
extern NSString * const kInvalidBillingCity;
extern NSString * const kInvalidBillingCountry;
extern NSString * const kInvalidBillingState;
extern NSString * const kInvalidBillingZIPCode;
extern NSString * const kInvalidSDKLanguage;
extern NSString * const kInvalidPhoneNumber;
extern NSString * const kInvalidShippingCountryCode;
extern NSString * const kInvalidBillingCountryCode;
extern NSString * const kInvalidCurrencyCode;
extern NSString * const kInvalidSecretKey;
extern NSString * const kInvalidCountryCode;
extern NSString * const kInvalidMerchantApplePayIdentifier;

extern NSString * const kEmptyCreditCardNumber;
extern NSString * const kEmptyCreditCardHolderName;
extern NSString * const kEmptyCreditCardExpiryDate;
extern NSString * const kEmptyCreditCardCVV;
extern NSString * const kInvalidCreditCardHolderName;
extern NSString * const kInvalidCreditCardNumber;
extern NSString * const kInvalidCreditCardCVVNumber;
extern NSString * const kInvalidCreditCardExpiryDate;

#pragma mark - Arabic
extern NSString * const kArabicPleaseWait;
extern NSString * const kArabicCreditCardNameHeader;
extern NSString * const kArabicCreditCardNumberHeader;
extern NSString * const kArabicCreditCardExpiryDateHeader;
extern NSString * const kArabicCreditCardNamePlaceholder;
extern NSString * const kArabicCreditCardNumberPlaceholder;
extern NSString * const kArabicCreditCardExpiryMonthPlaceholder;
extern NSString * const kArabicCreditCardExpiryYearPlaceholder;
extern NSString * const kArabicCreditCardCVVPlaceholder;
extern NSString * const kArabicPayNowButtonTitle;
extern NSString * const kArabicContinueButtonTitle;
extern NSString * const kArabicTransactionSuccessfulText;
extern NSString * const kArabicTransactionUnsuccessfulText;
extern NSString * const kArabicTransactionIDHeaderText;

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

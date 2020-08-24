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

extern NSString * const kAlertTitle_ar;
extern NSString * const kErrorTitle_ar;
extern NSString * const kSuccessTitle_ar;
extern NSString * const kDismissTitle_ar;
extern NSString * const kInternetNotAvailable_ar;
extern NSString * const kInternetNotAccessible_ar;
extern NSString * const kAuthorizationFailed_ar;
extern NSString * const kSomethingGoesWrong_ar;
extern NSString * const kOperationTimedOut_ar;
extern NSString * const kNetworkFailed_ar;


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

extern NSString * const kEmptyAmount_ar;
extern NSString * const kEmptyCustomerTitle_ar;
extern NSString * const kEmptyCurrencyCode_ar;
extern NSString * const kEmptyTaxAmount_ar;
extern NSString * const kEmptySDKLanguage_ar;
extern NSString * const kEmptyShippingAddress_ar;
extern NSString * const kEmptyShippingCity_ar;
extern NSString * const kEmptyShippingCountry_ar;
extern NSString * const kEmptyShippingState_ar;
extern NSString * const kEmptyShippingZIPCode_ar;
extern NSString * const kEmptyBillingAddress_ar;
extern NSString * const kEmptyBillingCity_ar;
extern NSString * const kEmptyBillingCountry_ar;
extern NSString * const kEmptyBillingState_ar;
extern NSString * const kEmptyBillingZIPCode_ar;
extern NSString * const kEmptyOrderID_ar;
extern NSString * const kEmptyPhoneNumber_ar;
extern NSString * const kEmptyCustomerEmail_ar;
extern NSString * const kEmptyCustomerPassword_ar;
extern NSString * const kEmptyPaytabsToken_ar;
extern NSString * const kEmptyMerchantEmail_ar;
extern NSString * const kEmptyMerchantSecretKey_ar;
extern NSString * const kEmptyAssigneeCode_ar;
extern NSString * const kEmptyTimeoutSeconds_ar;
extern NSString * const kInvalidCustomerEmail_ar;
extern NSString * const kInvalidMerchantEmail_ar;
extern NSString * const kInvalidShippingAddress_ar;
extern NSString * const kInvalidShippingCity_ar;
extern NSString * const kInvalidShippingCountry_ar;
extern NSString * const kInvalidShippingState_ar;
extern NSString * const kInvalidShippingZIPCode_ar;
extern NSString * const kInvalidBillingAddress_ar;
extern NSString * const kInvalidBillingCity_ar;
extern NSString * const kInvalidBillingCountry_ar;
extern NSString * const kInvalidBillingState_ar;
extern NSString * const kInvalidBillingZIPCode_ar;
extern NSString * const kInvalidSDKLanguage_ar;
extern NSString * const kInvalidPhoneNumber_ar;
extern NSString * const kInvalidShippingCountryCode_ar;
extern NSString * const kInvalidBillingCountryCode_ar;
extern NSString * const kInvalidCurrencyCode_ar;
extern NSString * const kInvalidSecretKey_ar;
extern NSString * const kInvalidCountryCode_ar;
extern NSString * const kInvalidMerchantApplePayIdentifier_ar;


extern NSString * const kEmptyCreditCardNumber;
extern NSString * const kEmptyCreditCardHolderName;
extern NSString * const kEmptyCreditCardExpiryDate;
extern NSString * const kEmptyCreditCardCVV;
extern NSString * const kInvalidCreditCardHolderName;
extern NSString * const kInvalidCreditCardNumber;
extern NSString * const kInvalidCreditCardCVVNumber;
extern NSString * const kInvalidCreditCardExpiryDate;

extern NSString * const kEmptyCreditCardNumber_ar;
extern NSString * const kEmptyCreditCardHolderName_ar;
extern NSString * const kEmptyCreditCardExpiryDate_ar;
extern NSString * const kEmptyCreditCardCVV_ar;
extern NSString * const kInvalidCreditCardHolderName_ar;
extern NSString * const kInvalidCreditCardNumber_ar;
extern NSString * const kInvalidCreditCardCVVNumber_ar;
extern NSString * const kInvalidCreditCardExpiryDate_ar;


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

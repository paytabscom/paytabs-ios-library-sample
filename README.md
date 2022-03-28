[![CocoaPods](https://img.shields.io/cocoapods/v/ClickPay.svg?style=flat)](http://cocoapods.org/?q=ClickPay)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/ClickPay.svg?style=flat)][license]
[![Platform](https://img.shields.io/cocoapods/p/ClickPay.svg?style=flat)](https://github.com/paytabscom/paytabs-ios-library-sample/tree/clickpay)

# ClickPay SDK
**ClickPay SDk** makes the intergation with ClickPay payment gateway very easy by providing ready made payment screen that handles the card entry and billing & shipping info and complete the missing details. 

## Features

* The SDk offers a ready-made card payment screen.
* **Card Scanner** for quick & easy entry of card details (iOS 13.0+). 
* Handle the missing required billing and shipping details.
* Logo, colors, and fonts become easy to be customized.
* **Apple Pay** supported.
* The SDK size became very light because we removed all the third-party dependencies.
* Supporting dark mode.


## Requirements
* iOS 10.0+
* Xcode 10.0+
* Create a [ClickPay](https://merchant.clickpay.com.sa) merchant account relative to your country.

## Installation

### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate **ClickPay SDK** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'ClickPay', '~> 6.1.17'
```
### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate **ClickPay SDK** into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "paytabscom/paytabs-ios-library-sample" ~> 6.1.17
```
### Manual
Follow the below steps:

1. Download the [framework](https://github.com/paytabscom/paytabs-ios-library-sample/tree/clickpay/sources/PaymentSDK.xcframework).
2. Navigate to `General` section of your `Target`.
3. Drag `PaymentSDK.xcframework` file to `Frameworks, Libraries, and Embedded Content` section.

![](https://user-images.githubusercontent.com/13621658/113698051-564c3480-96d4-11eb-8a87-4b9f646e2b5d.png)

## Prerequisites
Before starting the integrations with ClickPay SDK you should check the Prerequisites below:

* To give **Card Scanner** the access permission to the camera, you should add the following key & value to your app `info.plist` file. 
```xml
<key>NSCameraUsageDescription</key>
<string>Write here your message to the user</string>
```

## Usage
Import the `PaymentSDK` in your code

```swift
import PaymentSDK

```
### Pay with Card


1. Configure the billing & shipping info, the shipping info is optional

```swift
let billingDetails = PaymentSDKBillingDetails(name: "John Smith",
                                     	   email: "email@test.com",
                                     	   phone: "+96611111111",
                                     	   addressLine: "address",
                                     	   city: "Dubai",
                                           state: "Dubai",
                                           countryCode: "ae", // ISO alpha 2
                                           zip: "12345")
                                                   
let shippingDetails = PaymentSDKShippingDetails(name: "John Smith",
                                     	   email: "email@test.com",
                                     	   phone: "+96611111111",
                                     	   addressLine: "address",
                                     	   city: "Dubai",
                                           state: "Dubai",
                                           countryCode: "ae", // ISO alpha 2
                                           zip: "12345")
                                              
```

2. Create object of `PaymentSDKConfiguration` and fill it with your credentials and payment details.

```
let configuration = PaymentSDKConfiguration(profileID: "profile id",
                                       serverKey: "server key",
                                       clientKey: "client key",
                                       currency: "SAR",
                                       amount: 5.0,
                                       merchantCountryCode: "SA")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .billingDetails(billingDetails)

```

3. You are now ready to start payment and handle `PaymentManagerDelegate` 

```swift
PaymentManager.startCardPayment(on: self, 
							 configuration: configuration,
							 delegate: self)

```

### Pay with Apple Pay

1. Follow the guide [Steps to configure Apple Pay][applepayguide] to learn how to configure ApplePay with ClickPay.

2. Do the steps 1 and 2 from **Pay with Card** although you can ignore Billing & Shipping details and Apple Pay will handle it, also you must pass the **merchant name** and **merchant identifier** parameters.

```
let configuration = PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "SAR",
                                       amount: 5.0,
                                       merchantCountryCode: "SA")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .merchantName("Flowers Store")
            .merchantAppleBundleID("merchant.com.bundleID")
            .simplifyApplePayValidation(true)
                                    
```

3. To force ApplePay validation on all user's billing info, pass **forceApplePayValidation** parameter in the configuration with **true**.

4. Call `startApplePayPayment` to start payment

```swift
PaymentManager.startApplePayPayment(on: self, 
							 configuration: configuration,
							 delegate: self)
```

### Pay with Alternative Payment Methods
It becomes easy to integrate with other payment methods in your region like STCPay, OmanNet, KNet, Valu, Fawry, UnionPay, and Meeza, to serve a large sector of customers.

1. Do the steps 1 and 2 from **Pay with Card**
2. Choose one or more of the payment methods you want to support

```swift
configuration.alternativePaymentMethods = [.stcPay]
```

3. Call `startAlternativePaymentMethod` to start payment

```swift
PaymentManager.startAlternativePaymentMethod(on: self, 
                             configuration: configuration,
                             delegate: self)
```

### Delegates
Here you will receive the transaction details and errors.

```swift
extension ViewController: PaymentManagerDelegate {
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
        } else if let error = error {
            // Handle errors
        }
    }
}
```

## Tokenisation
To enable tokenisation, please follow the below instructions.

1. Request token

```swift
configuration.tokeniseType = .userOptinoal // read more about the tokeniseType in the enums section 
configuration.tokenFormat = .hex32 // read more about the tokenFormat in the enums section  

```
After passing those parameters, you will receive token and transaction reference in the delegate, save them for future usage.

2. Pass the token & transaction reference

```swift
configuration.token = token
configuration.transactionReference = transactionreference
```

## Theme
Use the following guide to cusomize the colors, font, and logo by configuring the theme and pass it to the payment configuration.

![UI guide](https://user-images.githubusercontent.com/95287975/160391259-97aaff10-cb9f-4103-bc3e-a938a1111128.png)

## Localization
You can use the strings file below to copy the key and add it to your app localizable file and overwrite the value to yours. 

* [English][englishstrings]
* [Arabic][arabicstrings]

## Enums

Those enums will help you in customizing your configuration.

* Tokenise types

 The default type is none

```swift
public enum TokeniseType: Int, Codable {
    case none // tokenise is off
    case merchantMandatory // tokenise is forced
    case userMandatory // tokenise is forced as per user approval
    case userOptinoal // tokenise if optional as per user approval
}
```

* Token formats

The default format is hex32

```swift
public enum TokenFormat: String {
    case none = "1"
    case hex32 = "2"
    case alphaNum20 = "3"
    case digit22 = "4"
    case digit16 = "5"
    case alphaNum32 = "6"
}
```

* Transaction types

The default type is sale

```swift
public enum TransactionType: String, CaseIterable {
    case sale
    case authorize = "auth"
}
```

```swift
configuration.transactionType = .sale
```
* Alternative Payment Methods

```swift
public enum AlternativePaymentMethod: String {
    case unionPay = "unionpay"
    case stcPay = "stcpay"
    case valu
    case meezaQR = "meezaqr"
    case omannet
    case knetCredit  = "knetcredit"
    case knetDebit  = "knetdebit"
    case fawry
}
```

```swift
configuration.transactionType = .sale
```

## Demo application

Check our complete [example][example].

<img src="https://user-images.githubusercontent.com/95287975/160391395-a8e591fc-85ed-459d-b0ce-1768d3bddd8a.png" width="370">

## License

See [LICENSE][license].

## ClickPay

[Support][1] | [Terms of Use][2] | [Privacy Policy][3]

 [1]: https://support.paytabs.com/
 [2]: https://www.paytabs.com/en/terms-of-use/
 [3]: https://www.paytabs.com/en/privacy-policy/
 [license]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/clickpay/LICENSE
 [example]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/clickpay/sample
 [englishstrings]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/clickpay/en.strings
 [arabicstrings]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/clickpay/ar.strings
[applepayguide]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/clickpay/ApplePayConfiguration.md

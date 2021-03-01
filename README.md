[![CocoaPods](https://img.shields.io/cocoapods/v/PayTabsSDK.svg?style=flat)](http://cocoapods.org/?q=PayTabsSDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/PayTabsSDK.svg?style=flat)][license]
[![Platform](https://img.shields.io/cocoapods/p/PayTabsSDK.svg?style=flat)](https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2)

# PayTabs SDK
**PayTabs SDk** makes the intergation with PayTabs payment gateway very easy by providing ready made payment screen that handles the credit card entry and billing & shipping info and complete the missing details. 

## Features

* The SDk offers a ready-made credit card payment screen.
* **Card Scanner** for quick & easy entry of credit details (iOS 13.0+). 
* Handle the missing required billing and shipping details.
* Logo, colors, and fonts become easy to be customized.
* **Apple Pay** supported.
* The SDK size became very light because we removed all the third-party dependencies.
* Supporting dark mode.


## Requirements
* iOS 10.0+
* Xcode 10.0+
* Create a [PayTabs](www.paytabs.com) merchant account relative to your country.

## Installation

### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate **PayTabs SDK** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'PayTabsSDK', '~> 6.0.2-beta'
```
### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate **PayTabs SDK** into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "paytabscom/paytabs-ios-library-sample" ~> 6.0.2-beta
```
### Manual
Follow the below steps:

1. Download the [framework](https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/sources/PayTabs.framework).
2. Navigate to `General` section of your `Target`.
3. Drag `PayTabs.framework` file to `Frameworks, Libraries, and Embedded Content` section.

![paytabs_manual_installation](https://user-images.githubusercontent.com/13621658/109430655-29d53680-7a0b-11eb-9d51-26c9af281384.jpg)

## Prerequisites
Before starting the integrations with PayTabs SDK you should check the Prerequisites below:

* To give **Credit Card Scanner** the access permission to the camera, you should add the following key & value to your app `info.plist` file. 
```xml
<key>NSCameraUsageDescription</key>
<string>Write here your message to the user</string>
```

## Usage
Import the `PayTabs` in your code

```swift
import PayTabs

```
### Pay with Credit Card


1. Configure the billing & shipping info, the shipping info is optional

```swift
let billingDetails = PayTabsBillingDetails(name: "John Smith",
                                     	   email: "email@test.com",
                                     	   phone: "+2011111111",
                                     	   addressLine: "address",
                                     	   city: "Dubai",
                                           state: "Dubai",
                                           countryCode: "ae", // ISO alpha 2
                                           zip: "12345")
                                                   
let shippingDetails = PayTabsShippingDetails(name: "John Smith",
                                     	   email: "email@test.com",
                                     	   phone: "+2011111111",
                                     	   addressLine: "address",
                                     	   city: "Dubai",
                                           state: "Dubai",
                                           countryCode: "ae", // ISO alpha 2
                                           zip: "12345")
                                              
```

2. Create object of `PayTabsConfiguration` and fill it with your credentials and payment details.

```
let configuration = PayTabsConfiguration(profileID: "*your profile id*",
                                    serverKey: "*server key*",
                                    clientKey: "*client key*",
                                    cartID: "12345",
                                    currency: "AED",
                                    amount: 5.0,
                                    cartDescription: "Flowers",
                                    merchantCountryCode: "ae", // ISO alpha 2
                                    showBillingInfo: true,
                                    screenTitle: "Pay with Card",
                                    billingDetails: billingDetails)
```

3. You are now ready to start payment and handle `PayTabsPaymentDelegate` 

```swift
PayTabs.startCardPayment(on: self, 
							 configuration: configuration,
							 delegate: self)

```

### Pay with Apple Pay

1. Do the steps 1 and 2 from **Pay with Credit Card** although you can ignore Billing & Shipping details and Apple Pay will handle it, also you must pass the **merchant name** and **merchant identifier**.

```
let configuration = PayTabsConfiguration(profileID: "*your profile id*",
                                    serverKey: "*server key*",
                                    clientKey: "*client key*",
                                    cartID: "12345",
                                    currency: "AED",
                                    amount: 5.0,
                                    merchantName: "Flowers Store",
                                    cartDescription: "Flowers",
                                    merchantCountryCode: "ae", // ISO alpha 2
                                    merchantIdentifier: "merchant.com.bundleID",
                                    paymentNetworks: nil,
                                    forceShippingInfo: false,
                                    billingDetails: billingDetails)
                                    
```


2. Call `startApplePayPayment` to start payment

```swift
PayTabs.startApplePayPayment(on: self, 
							 configuration: configuration,
							 delegate: self)
```

### Delegates
Here you will receive the transaction details and errors.

```swift
extension ViewController: PayTabsPaymentDelegate {
    func paytabs(didFinishTransaction transactionDetails: PayTabsTransactionDetails?, error: Error?) {
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

![UI guide](https://user-images.githubusercontent.com/13621658/109432213-d7981380-7a12-11eb-9224-c8fc12b0024d.jpg)

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

## Demo application

Check our complete [example][example].

<img src="https://user-images.githubusercontent.com/13621658/109432386-905e5280-7a13-11eb-847c-63f2c554e2d1.png" width="370">

## License

See [LICENSE][license].

## Paytabs

[Support][1] | [Terms of Use][2] | [Privacy Policy][3]

 [1]: https://support.paytabs.com/
 [2]: https://www.paytabs.com/en/terms-of-use/
 [3]: https://www.paytabs.com/en/privacy-policy/
 [license]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/PT2/LICENSE
 [example]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/sample
 [englishstrings]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/en.strings
 [arabicstrings]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/ar.strings

[![CocoaPods](https://img.shields.io/cocoapods/v/PayTabsSDK.svg?style=flat)](http://cocoapods.org/?q=PayTabsSDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/PayTabsSDK.svg?style=flat)][license]
[![Platform](https://img.shields.io/cocoapods/p/PayTabsSDK.svg?style=flat)](https://github.com/paytabscom/paytabs-ios-library-sample/tree/master)

# PayTabs SDK
**PayTabs SDk** makes the intergation with the PayTabs payment gateway very easy by providing ready-made payment screen that handles the card entry and billing & shipping info and completes the missing details. 

## Features

* The SDK offers a ready-made card payment screen.
* **Card Scanner** for quick & easy entry of card details (iOS 13.0+). 
* Handle the missing required billing and shipping details.
* Logo, colors, and fonts become easy to customize.
* **Apple Pay** supported.
* The SDK size became very light because we removed all the third-party dependencies.
* Supporting dark mode.
* Supporting alternative payment methods.
* Supporting recurring with 3DS.
* Supporting the ability to save and list cards.


## Requirements
* iOS 11.0+, Swift 5.0+
* Xcode 11.0+
* Create a [PayTabs](www.paytabs.com) merchant account relative to your country.

## Installation

### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate **PayTabs SDK** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'PayTabsSDK', '~> 6.6.18'
```
### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate **PayTabs SDK** into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "paytabscom/paytabs-ios-library-sample" ~> 6.6.18
```

### Swift Package Manager 
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

Once you have your Swift package set up, adding PayTabsSDK as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```ruby
dependencies: [
    .package(url: "https://github.com/paytabscom/paytabs-ios-library-sample.git", .upToNextMajor(from: "6.6.18"))
]
```

### Manual
Follow the below steps:

1. Download the [framework](https://github.com/paytabscom/paytabs-ios-library-sample/tree/master/sources/PaymentSDK.xcframework).
2. Navigate to `General` section of your `Target`.
3. Drag `PaymentSDK.xcframework` file to `Frameworks, Libraries, and Embedded Content` section.

![](https://user-images.githubusercontent.com/13621658/113698051-564c3480-96d4-11eb-8a87-4b9f646e2b5d.png)

## Prerequisites
Before starting the integrations with PayTabs SDK you should check the Prerequisites below:

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
                                            phone: "+2011111111",
                                            addressLine: "address",
                                            city: "Dubai",
                                           state: "Dubai",
                                           countryCode: "ae", // ISO alpha 2
                                           zip: "12345")
                                                   
let shippingDetails = PaymentSDKShippingDetails(name: "John Smith",
                                            email: "email@test.com",
                                            phone: "+2011111111",
                                            addressLine: "address",
                                            city: "Dubai",
                                           state: "Dubai",
                                           countryCode: "ae", // ISO alpha 2
                                           zip: "12345")
                                              
```

2. Create object of `PaymentSDKConfiguration` and fill it with your credentials and payment details.

```
let configuration = PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "AED",
                                       amount: 5.0,
                                       merchantCountryCode: "AE")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .billingDetails(billingDetails)
	    .isDigitalProduct(true)
```


Options to set expiry timeout for the card payment screen

```
configuration.expiryTime =120
```

Options to add discounts on card payment

```
  let cardDiscounts: [PaymentSDKCardDiscount] = [
            PaymentSDKCardDiscount(discountCards: ["4001"], dicsountValue: 90.0, discountTitle: "● 90% discount - 40001, 90% discount - 40001, 90% discount - 40001", isPercentage: true),
            PaymentSDKCardDiscount(discountCards: ["4000", "4111", "400012"], dicsountValue: 1.0, discountTitle: "● 1% discount - 4000,4111,400012", isPercentage: true),
            PaymentSDKCardDiscount(discountCards: ["5498", "5200"], dicsountValue: 2.0, discountTitle: "● 2% discount - 5498,5299 (977)", isPercentage: true),
            PaymentSDKCardDiscount(discountCards: ["4012"], dicsountValue: 5.0, discountTitle: "● 5 discount - 4012 (530)", isPercentage: false)
        ]
configuration.cardDiscounts = cardDiscounts
```
Each instance of PaymentSDKCardDiscount is initialized with parameters corresponding to the accepted card types (discountCards), the value of the discount (discountValue), the title of the discount (discountTitle), and whether the discount is a percentage (isPercentage).



You have the option to close the payment screen if there are no ongoing transactions.
```swift
 PaymentManager.cancelPayment { didCancel in
                if didCancel {
			//do something
            }
```


3. You are now ready to start payment and handle `PaymentManagerDelegate`
	* For normal card payment use: 
	
	```swift
    PaymentManager.startCardPayment(on: self, 
                             configuration: configuration,
                             delegate: self)

	```
	<img src="https://user-images.githubusercontent.com/95287975/188839186-8c4e5996-d9f2-4faa-817d-1550f2c898a6.png" width="370">
	
	* For tokenized payment use: 
	
	```swift
    PaymentManager.startTokenizedCardPayment(on: self, 
                             configuration: configuration,
                             token: *token*,
                             transactionRef: *transactionReference*
                             delegate: self)
	```
	
	* For tokenized payment with 3DS feature enabled (request CVV) use:
	
	```swift
    PaymentManager.start3DSecureTokenizedCardPayment(on: self, 
                             configuration: configuration,
                             savedCardInfo: SavedCardInfo,
                             token: *token*
                             delegate: self)
	```
	<img src="https://user-images.githubusercontent.com/95287975/188839218-23f0a37b-7add-4a9e-93e3-8b009f0ec5c0.png" width="370">
	
	* For payment with the ability to let SDK save Cards on your behalf and show sheet of saved cards for user to choose from. use:
	
	```swift
    PaymentManager.startPaymentWithSavedCards(on: self, 
                             configuration: configuration,
                             support3DS: true,
                             delegate: self)
	```
	<img src="https://user-images.githubusercontent.com/95287975/188841787-44d172e9-3791-4d33-90ea-7dbe9f2d04af.png" width="370">
### Pay with Apple Pay

1. Follow the guide [Steps to configure Apple Pay][applepayguide] to learn how to configure ApplePay with PayTabs.

2. Do the steps 1 and 2 from **Pay with Card** although you can ignore Billing & Shipping details and Apple Pay will handle it, also you must pass the **merchant name** and **merchant identifier** parameters.

```
let configuration = PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "AED",
                                       amount: 5.0,
                                       merchantCountryCode: "AE")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .merchantName("Flowers Store")
            .merchantAppleBundleID("merchant.com.bundleID")
            .simplifyApplePayValidation(true)
                                    
```

3. To simplify ApplePay validation on all user's billing info, pass **simplifyApplePayValidation** parameter in the configuration with **true**.

```swift
configuration.simplifyApplePayValidation = true
```

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

### Query Transaction
You can check the status of a transaction

1- first create PaymentSDKQueryConfiguration

```swift
  let config = PaymentSDKQueryConfiguration(serverKey: "*ServerKey*",
                                              clientKey: "*ClientKey*",
                                              merchantCountryCode: "*CountryCode*",
                                              profileID: "*ProfileId*",
					      transactionReference: "*TransactionReference*")
```
					      
2- call queryTransaction function

```swift
          PaymentManager.queryTransaction(queryConfiguration: config) { transactionDetails, error in
            if let tranDet = transactionDetails {
                //handle transcation details
            } else if let err = error {
                //handle error
            }
        }
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
       if transactionDetails.isSuccess() {
                print("Successful transaction")
          }
        } else if let error = error {
            // Handle errors
        }
    }
}
```

### Handling Transaction response
you can use transactionDetails?.isSuccess() to ensure a successful transaction ..

if the transaction is not successful you should check for the corresponding failure code you will receive the code in 
```transactionDetails?.paymentResult?.responseCode ``` .. all codes can be found in  [Payment Response Codes][responseCodes]

## Force Shipping Info Validation
By default, the validation on shipping info is disabled.

```swift
configuration.forceShippingInfo = true
```

## Show Billing or Shipping Info Section
By default, the billing and shipping info section is disappeared, sets its flag to `true` to let the SDK internally handle the missing billing & shipping info.

```swift
configuration.showBillingInfo = true
configuration.showShippingInfo = true
```

## Link billing name with card holder name
By default, the billing name is linked with card holder name, if you set its flag to `false` the billing name and the card holder name will be seperated
```
configuration.linkBillingNameWithCard = true
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

![UI guide](https://github-production-user-asset-6210df.s3.amazonaws.com/95287975/332021756-2c9742d7-7651-4f57-a919-2b9bf54aa37c.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20240520%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240520T095553Z&X-Amz-Expires=300&X-Amz-Signature=529d9fb31eb99f9d7a1cd388a98b7433ebc70db979d25f15a682332546297da6&X-Amz-SignedHeaders=host&actor_id=95287975&key_id=0&repo_id=165845609)

```swift
let theme = PaymentSDKTheme.default
theme.logoImage = UIImage(named: "Logo") //Change merchant logo.
theme.backgroundColor = .blue
theme.buttonFontColor = .red
configuration.theme = theme
```

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

* Transaction Type

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
    case aman
    case URPay = "urpay"
    case applePay = "applePay"
    case souhoola = "souhoola"
    case Tabby = "tabby" 
}
```

```swift
configuration.transactionType = .sale
```


## Demo application

Check our complete examples [For UIKit][example], [For SwiftUI][swiftui].

<img src="https://user-images.githubusercontent.com/13621658/109432386-905e5280-7a13-11eb-847c-63f2c554e2d1.png" width="370">

## License

See [LICENSE][license].

## Paytabs

[Support][1] | [Terms of Use][2] | [Privacy Policy][3]

 [1]: https://support.paytabs.com/
 [2]: https://www.paytabs.com/en/terms-of-use/
 [3]: https://www.paytabs.com/en/privacy-policy/
 [license]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/master/LICENSE
 [example]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/master/sample
 [swiftui]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/master/sample-swiftui
 [englishstrings]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/master/en.strings
 [arabicstrings]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/master/ar.strings
 [applepayguide]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/master/ApplePayConfiguration.md
 [responseCodes]: https://site.paytabs.com/en/pt2-documentation/testing/payment-response-codes/

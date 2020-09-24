PayTabs iOS SDK
========
![Paytabs-ios-library-v4.0.8](https://img.shields.io/badge/Paytabs%20IOS%20library-v4.0.10-green.svg)
![xcode-v10.1](https://img.shields.io/badge/xcode-v10.1-green.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/PayTabs.svg?style=flat)](https://cocoapods.org/pods/PayTabs)

For more information please see [the website][1].


## Installation

### CocoaPods

Simply add the following line to your `Podfile`:

```ruby
pod 'PayTabs', '~> 4.1.0'
```

### Manual

Download [SDK][sdk] and [Resource bundle][bundle] then read the documentation to know how to integrate your application with the library
[documentation](https://dev.paytabs.com/docs/ios/)

Static framework requires at minimum deployment target 9.0.

You have to include the following dependencies in your  `Podfile`:
```ruby
  pod 'BIObjCHelpers'
  pod 'AFNetworking', '~> 4.0.1'
  pod 'Mantle'
  pod 'Reachability'
  pod 'Lockbox'
  pod 'SBJson'
  pod 'PINCache'
  pod 'CardIO'
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'ActionSheetPicker-3.0'
```

You might face an issue when you try to install the SDK manually while "ENABLE_BITCODE" flag enabled, you will have to include the following script to your `Podfile`:

```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
            config.build_settings['ENABLE_BITCODE'] = 'YES'
        end
    end
end
```
## Usage

### Pay with PayTabs

```swift
let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
self.initialSetupViewController = PTFWInitialSetupViewController.init(
    bundle: bundle,
    andWithViewFrame: self.view.frame,
    andWithAmount: 5.0,
    andWithCustomerTitle: "PayTabs Sample App",
    andWithCurrencyCode: "USD",
    andWithTaxAmount: 0.0,
    andWithSDKLanguage: "en",
    andWithShippingAddress: "Dubai",
    andWithShippingCity: "Dubai",
    andWithShippingCountry: "ARE",
    andWithShippingState: "Dubai",
    andWithShippingZIPCode: "123456",
    andWithBillingAddress: "Dubai",
    andWithBillingCity: "Dubai",
    andWithBillingCountry: "ARE",
    andWithBillingState: "Dubai",
    andWithBillingZIPCode: "12345",
    andWithOrderID: "12345",
    andWithPhoneNumber: "009730000000",
    andWithCustomerEmail: "test@example.com",
    andIsTokenization:true,
    andIsPreAuth: false,
    andWithMerchantEmail: "test@example.com",
    andWithMerchantSecretKey: "kuTEjyEMhpVSWTwXBSOSeiiDAeMCOdyeuFZKiXAlhzjSKqswUWAgbCaYFivjvYzCWaWJbRszhjZuEQqsUycVzLddSyMIaZiQLlRqlp",
    andWithAssigneeCode: "SDK",
    andWithThemeColor:UIColor.red,
    andIsThemeColorLight: false)


self.initialSetupViewController.didReceiveBackButtonCallback = {
    
}

self.initialSetupViewController.didStartPreparePaymentPage = {
    // Start Prepare Payment Page
    // Show loading indicator
}
self.initialSetupViewController.didFinishPreparePaymentPage = {
    // Finish Prepare Payment Page
    // Stop loading indicator
}

self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState, statementReference, traceCode) in
    print("Response Code: \(responseCode)")
    print("Response Result: \(result)")
    print("Statement Reference: \(statementReference)");
    print("Trace Code: \(traceCode)");
    
    // In Case you are using tokenization
    print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
    print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
    print("Tokenization Token: \(token)");
}

self.view.addSubview(initialSetupViewController.view)
self.addChild(initialSetupViewController)

initialSetupViewController.didMove(toParent: self)

```

### Pay with Apple Pay

Read the developer document [here][applepaydoc] to learn how to integrate Apple Pay with PayTabs. 

```swift
let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
self.initialSetupViewController = PTFWInitialSetupViewController.init(applePayWith: bundle,
    andWithViewFrame: view.frame,
    andWithAmount: 1.0,
    andWithCustomerTitle: "Pay With Apple Pay",
    andWithCurrencyCode: "AED",
    andWithCountryCode: "AE",
    andWithSDKLanguage: "en",
    andWithOrderID: "123456",
    andIsTokenization: true,
    andIsPreAuth: false,
    andWithMerchantEmail: "test@example.com",
    andWithMerchantSecretKey: "kuTEjyEMhpVSWTwXBSOSeiiDAeMCOdyeuFZKiXAlhzjSKqswUWAgbCaYFivjvYzCWaWJbRszhjZddQqsUycVzLSyMIaZiQLlRqlp",
    andWithMerchantApplePayIdentifier: "merchant.bundleid",
    andWithSupportedNetworks: [.visa, .masterCard, .amex],
    andWithAssigneeCode: "SDK")

self.initialSetupViewController.didReceiveBackButtonCallback = {

}

self.initialSetupViewController.didStartPreparePaymentPage = {
  // Start Prepare Payment Page
  // Show loading indicator
}
self.initialSetupViewController.didFinishPreparePaymentPage = {
  // Finish Prepare Payment Page
  // Stop loading indicator
}

self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState, statementReference, traceCode) in
    print("Response Code: \(responseCode)")
    print("Response Result: \(result)")
    print("Statement Reference: \(statementReference)");
    print("Trace Code: \(traceCode)");
    
    // In Case you are using tokenization
    print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
    print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
    print("Tokenization Token: \(token)");
}

self.view.addSubview(initialSetupViewController.view)
self.addChild(initialSetupViewController)
initialSetupViewController.didMove(toParent: self)
```

## Demo application

Check our complete [sample][sample].

## Paytabs
[Support][2] | [Terms of Use][3] | [Privacy Policy][4]

 [1]: https://dev.paytabs.com/docs/ios/
 [2]: https://www.paytabs.com/en/support/
 [3]: https://www.paytabs.com/en/terms-of-use/
 [4]: https://www.paytabs.com/en/privacy-policy/
 [sdk]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/sources/paytabs-iOS.framework
 [bundle]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/sources/Resources.bundle
 [sample]: https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2/sample
 [applepaydoc]: https://dev.paytabs.com/docs/ios/#configure-apple-pay

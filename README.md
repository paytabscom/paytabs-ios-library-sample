PayTabs iOS SDK
========
![Paytabs-ios-library-v4.3.0](https://img.shields.io/badge/Paytabs%20IOS%20library-v4.3.0-green.svg)
![xcode-v10.1](https://img.shields.io/badge/xcode-v10.1-green.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/PayTabs.svg?style=flat)](http://cocoapods.org/?q=PayTabs)

For more information please see [the website][1].


## Installation

### CocoaPods

Simply add the following line to your `Podfile`:

```ruby
pod 'PayTabs', '~> 4.3.0'
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

* To skip the shipping info use the following method

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
    andWithMerchantRegion: "emirates",
    andWithAssigneeCode: "SDK",
    andWithThemeColor:UIColor.red,
    andIsThemeColorLight: false)
```

* To pass the billing & shipping info use the following method

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
    andWithMerchantRegion: "emirates",//egypt, saudi, oman, jordan
    andWithAssigneeCode: "SDK",
    andWithThemeColor:UIColor.red,
    andIsThemeColorLight: false)

```

### Pay with Apple Pay

----
**Apple Pay Guidelines**

The SDK doesn't add the apple pay button, please use [PKPaymentButton](https://developer.apple.com/documentation/passkit/pkpaymentbutton), and call our API once user click the button. You have to add the button according to [Apple human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/apple-pay/overview/buttons-and-marks/).

**Configure Apple Pay**

Check [apple pay requirements](https://developer.apple.com/documentation/passkit/apple_pay/setting_up_apple_pay_requirements) before getting started with configuration.

**Enable Apple Pay in XCode**

1.  In the Project navigator of the main window, select the project (the root group with the same name as your app).

2. In the project editor that appears on the right, select the target.

3. Choose the target for the app from either the Project/Targets pop-up menu or in the Targets section of the outline view.

4. Then click the **Signing & Capabilities** tab in the project editor.

5. Click on ( **+ Capability**) to open the Capabilities library, The choose **Sing in with Apple** and double on it.

![image](https://user-images.githubusercontent.com/69899730/104327365-5c76ae80-54f3-11eb-8fb9-95e66d31a343.png)

5.  Add your merchant identifier ( [You will use it later with andWithMerchantApplePayIdentifier](https://dev1.paytabs.net/docs/docs/ios/#apple-pay))

![image](https://user-images.githubusercontent.com/69899730/104327415-6a2c3400-54f3-11eb-80a1-d57a2f3861dc.png)

**Payment processing certificate**

1. Generate CSR via [PT2 merchant dashboard/ Certificate Management](https://merchant.paytabs.com/merchant/developers/certs) and Download generated CSR on [Apple Pay developer portal](https://developer.apple.com/apple-pay/).

![](https://user-images.githubusercontent.com/69899730/104328421-76fd5780-54f4-11eb-8c38-885e0862748a.png)

2. Download the certificate from Apple pay developer portal and upload it via [PT2 merchant dashboard/ Certificate Management](https://merchant.paytabs.com/merchant/developers/certs) and entering Merchant Identifier.

![](https://user-images.githubusercontent.com/69899730/104328431-782e8480-54f4-11eb-8851-290cd5961dcd.png)

**Apple Pay testing**

To learn how to create Apple Pay sandbox tester and use test cards please visit this link [https://developer.apple.com/apple-pay/sandbox-testing/](https://developer.apple.com/apple-pay/sandbox-testing/)

-----------
**Now you are ready to start payment with Apple Pay**

Use **andForceShippingInfo** parameter to make the shipping info mandatory or optional.

```swift
let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
self.initialSetupViewController = PTFWInitialSetupViewController.init(applePayWith: bundle,
    andWithViewFrame: view.frame,
    andWithAmount: 1.0,
    andWithCustomerTitle: "Pay With Apple Pay",
    andWithCurrencyCode: "AED",
    andWithCountryCode: "AE",
    andForceShippingInfo: false,
    andWithSDKLanguage: "en",
    andWithOrderID: "123456",
    andIsTokenization: true,
    andIsPreAuth: false,
    andWithMerchantEmail: "test@example.com",
    andWithMerchantSecretKey: "kuTEjyEMhpVSWTwXBSOSeiiDAeMCOdyeuFZKiXAlhzjSKqswUWAgbCaYFivjvYzCWaWJbRszhjZddQqsUycVzLSyMIaZiQLlRqlp",
    andWithMerchantApplePayIdentifier: "merchant.bundleid",
    andWithSupportedNetworks: [.visa, .masterCard, .amex, .mada],
    andWithMerchantRegion: "emirates", //egypt, saudi, oman, jordan
    andWithAssigneeCode: "SDK")

```

### Payment callbacks :

```swift
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
# Supported merchant region
Pass the parameter `pt_merchant_region` with one value of the below list according to supported region.

* UAE = `emirates`
* Egypt = `egypt`
* Saudi Arabia = `saudi`
* Oman = `oman`
* Jordan = `jordan`
* Global =`global`
* Demo = `demo`

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

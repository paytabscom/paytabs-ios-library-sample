Paytabs iOS SDK Samples
========
![Paytabs-ios-library-v4.0.1](https://img.shields.io/badge/Paytabs%20IOS%20library-v4.0.1-green.svg)

For more information please see [the website][1].


Download
--------

Download [SDK V4.0.1 Lite version](https://raw.githubusercontent.com/paytabscom/paytabs-ios-library-sample/master/sdk/ios_sdk-v4.0.1-lite.zip)

Download [SDK V4.0.1 OCR version](https://raw.githubusercontent.com/paytabscom/paytabs-ios-library-sample/master/sdk/ios_sdk-v4.0.1-ocr.zip)

Read the documentation to know how to integrate your application with the library
[documentation](https://dev.paytabs.com/docs/ios/)


Static framework requires at minimum deployment target 9.0.

You have to include the following dependencies in your podfile:
```groovy
  # Uncomment the next line to define a global platform for your project
  # platform :ios, '9.0'

  target 'sample-run' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!

    # Pods for sample-run
    pod 'BIObjCHelpers'
    pod 'IQKeyboardManager', '~> 4.0.2'
    pod 'AFNetworking'
    pod 'Mantle'
    pod 'Reachability'
    pod 'Lockbox'
    pod 'SBJson'
    pod 'PINCache'
    pod 'MBProgressHUD', '~> 1.1.0'
    
    # In case if you are using OCR version 
    pod 'PayCardsRecognizer'

  end
```

Pay now
------------
```Swift
let bundle = Bundle(url: Bundle.main.url(forResource: ApplicationResources.kFrameworkResourcesBundle, withExtension: "bundle")!)
self.initialSetupViewController = PTFWInitialSetupViewController.init(
    bundle: bundle,
    andWithViewFrame: self.view.frame,
    andWithAmount: 1.0,
    andWithCustomerTitle: "PayTabs Sample App",
    andWithCurrencyCode: "SAR",
    andWithTaxAmount: 0.0,
    andWithSDKLanguage: "en",
    andWithShippingAddress: "Manama",
    andWithShippingCity: "Manama",
    andWithShippingCountry: "BHR",
    andWithShippingState: "Manama",
    andWithShippingZIPCode: "123456",
    andWithBillingAddress: "Manama",
    andWithBillingCity: "Manama",
    andWithBillingCountry: "BHR",
    andWithBillingState: "Manama",
    andWithBillingZIPCode: "12345",
    andWithOrderID: "12345",
    andWithPhoneNumber: "0097333109781",
    andWithCustomerEmail: "test@paytabs.com",
    andIsTokenization: FALSE,
    andIsPreAuth: FALSE,
    andWithMerchantEmail: "",
    andWithMerchantSecretKey: "",
    andWithAssigneeCode: "SDK",
    andWithThemeColor:UIColor.red,
    andIsThemeColorLight: TRUE)


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

self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
  print("Response Code: \(responseCode)")
  print("Response Result: \(result)")
  
  // In Case you are using tokenization
  print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
  print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
  print("TOkenization Token: \(token)");
}

```

Paytabs
-------
[Support][2] | [Terms of Use][3] | [Privacy Policy][4]




 [1]: https://dev.paytabs.com/docs/ios/
 [2]: https://www.paytabs.com/en/support/
 [3]: https://www.paytabs.com/en/terms-of-use/
 [4]: https://www.paytabs.com/en/privacy-policy/

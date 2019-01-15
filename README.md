Paytabs ios library sample
========
![Paytabs-ios-library-v3.0.0](https://img.shields.io/badge/Paytabs%20android%20library-v3.0.0-green.svg)

For more information please see [the website][1].


Download
--------

Download [the latest .framework and resources.bundle](sdk/iOSSDK_21102018.zip):

Read the documentation to know how to integrate your application with the library
[documentation v3.0](docs/paytabs-ios-sdk-3.0.pdf)

Static framework requires at minimum deployment target 9.0.

You have to include the following dependencies in your podfile:
```groovy
  pod 'BIObjCHelpers'
  pod 'AFNetworking'
  pod 'Mantle'
  pod 'Reachability'
  pod 'SDWebImage'
  pod 'DGActivityIndicatorView'
  pod 'Lockbox'
  pod 'YLGIFImage'
  pod 'SBJson'
  pod 'PINCache'
  pod 'IQKeyboardManager'
```

Initiate SDK
--------
```swift
 self.initialSetupViewController = PTFWInitialSetupViewController.init(
            nibName: ApplicationXIBs.kPTFWInitialSetupView,
            bundle: bundle,
            andWithViewFrame: self.view.frame,
            andWithAmount: Float(self.launcherView.amountTextField.text!)!,
            andWithCustomerTitle: "PayTabs",
            andWithCurrencyCode: self.launcherView.currencyTextField.text!,
            andWithTaxAmount: 0.0,
            andWithSDKLanguage: (self.launcherView.isArabic.isOn) ? "ar" : "en",
            andWithShippingAddress: "عُنوان البَريد الإلِكتْروني",
            andWithShippingCity: "jeddah عَنوِن / يَكتُب العُنوان™™™ 29393 .. 48493 $",
            andWithShippingCountry: "BHR",
            andWithShippingState: "123",
            andWithShippingZIPCode: "NBsdjbd.",
            andWithBillingAddress: "عُنوان البَريد الإلِكتْروني",
            andWithBillingCity: "Manama",
            andWithBillingCountry: "BHR",
            andWithBillingState: "Manama",
            andWithBillingZIPCode: "0097",
            andWithOrderID: "00987",
            andWithPhoneNumber: "0097335532915",
            andWithCustomerEmail: self.launcherView.customerEmailTextField.text!,
            andIsTokenization: self.launcherView.tokenizationSwitch.isOn,
            andWithMerchantEmail: self.launcherView.merchantEmailTextField.text!,
            andWithMerchantSecretKey: self.launcherView.merchantSecretKeyTextField.text!,
            andWithAssigneeCode: "SDK",
            andWithThemeColor: UIColor(red:  CGFloat((self.launcherView.redThemeValue.text! as NSString).doubleValue/255), green: CGFloat((self.launcherView.greenThemeValue.text! as NSString).doubleValue/255), blue: CGFloat((self.launcherView.bluehemeValue.text! as NSString).doubleValue/255), alpha: 1.0),
            andIsThemeColorLight: self.launcherView.isLightTheme.isOn)
```

Callbacks
--------
```swift
        weak var weakSelf = self
        self.initialSetupViewController.didReceiveBackButtonCallback = {
            weakSelf?.handleBackButtonTapEvent()
        }
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            self.launcherView.responseCodeLabel.text = "\(responseCode)"
            self.launcherView.resultLabel.text = "\(result)"
            self.launcherView.transactionIDLabel.text = "\(transactionID)"
            self.launcherView.customerEmailLabel.text = "\(tokenizedCustomerEmail)"
            self.launcherView.customerPasswordLabel.text = "\(tokenizedCustomerPassword)"
            self.launcherView.transactionStateLabel.text = "\(transactionState)"
            self.launcherView.tokenValueLabel.text = "\(token)"
            
            self.launcherView.responseView.isHidden = false
            
            weakSelf?.handleBackButtonTapEvent()
        }
```

Paytabs
--------
[Support][2] | [Terms of Use][3] | [Privacy Policy][4]




 [1]: https://dev.paytabs.com/docs-apis/#ios-sdk
 [2]: https://www.paytabs.com/en/support/
 [3]: https://www.paytabs.com/en/terms-of-use/
 [4]: https://www.paytabs.com/en/privacy-policy/

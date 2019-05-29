//
//  ViewController.swift
//  sample-run
//
//  Created by PayTabs LLC on 10/5/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

import UIKit

class PTSRLauncherViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var launcherView: PTSRLauncherView!
    
    // MARK: Instance Variables
    var initialSetupViewController: PTFWInitialSetupViewController!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.launcherView.amountTextField.text = "1";
        self.launcherView.customerEmailTextField.text = "humayun4206@gmail.com"
        self.launcherView.currencyTextField.text = "BHD"
        self.launcherView.merchantEmailTextField.text = "humayun@paytabs.com"
        self.launcherView.merchantSecretKeyTextField.text = "NXKkEpuYSMpvpeYEQzisFh4oUZzCLNIzKsUpSpnLbNhB1ffSPxkvPpTKosmag5K1yEqq3OceBtPDI5vyDQ3sgXcFqzQGEAHcf8Di"
        
        self.launcherView.redThemeValue.text = "225"
        self.launcherView.greenThemeValue.text = "225"
        self.launcherView.bluehemeValue.text = "225"

        self.configureCallbacks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    // MARK: Private Methods
    // MARK: Objects
    private func initiateSDK() {
        self.launcherView.endEditing(true)
        let bundle = Bundle(url: Bundle.main.url(forResource: ApplicationResources.kFrameworkResourcesBundle, withExtension: "bundle")!)
        
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
    }
    
    // MARK: Callbacks
    private func configureCallbacks() -> Void {
        weak var weakSelf = self
        
        self.launcherView.didPressHitTestRunButtonCallback = {
            weakSelf?.handleHitTestRunTapEvent()
        }
        
        self.launcherView.didPressResponseViewCloseButtonCallback = {
            weakSelf?.handleCloseResponseViewTapEvent()
        }
    }
    
    // MARK: Event Methods
    // MARK: Initiate SDK Event
    private func handleHitTestRunTapEvent() {
        if (self.launcherView.amountTextField.text?.count == 0) {
            let alertController = UIAlertController(title: "Alert", message:
                "Amount is empty!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else if (self.launcherView.merchantEmailTextField.text?.count == 0){
            let alertController = UIAlertController(title: "Alert", message:
                "Merchant Email is empty!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else if (self.launcherView.merchantSecretKeyTextField.text?.count == 0){
            let alertController = UIAlertController(title: "Alert", message:
                "Merchant SDK Key is empty!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else if self.launcherView.redThemeValue.text?.count == 0 || CGFloat((self.launcherView.redThemeValue.text! as NSString).doubleValue) < 0.00 || CGFloat((self.launcherView.redThemeValue.text! as NSString).doubleValue) > 255.0 {
            let alertController = UIAlertController(title: "Alert", message:
                "Red value should be between 0-255!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else if self.launcherView.greenThemeValue.text?.count == 0 || CGFloat((self.launcherView.greenThemeValue.text! as NSString).doubleValue) < 0.00 || CGFloat((self.launcherView.greenThemeValue.text! as NSString).doubleValue) > 255.0 {
            let alertController = UIAlertController(title: "Alert", message:
                "Green value should be between 0-255!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else if self.launcherView.bluehemeValue.text?.count == 0 || CGFloat((self.launcherView.bluehemeValue.text! as NSString).doubleValue) < 0.00 || CGFloat((self.launcherView.bluehemeValue.text! as NSString).doubleValue) > 255.0 {
            let alertController = UIAlertController(title: "Alert", message:
                "Blue value should be between 0-255!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else {
            self.initiateSDK()
            
            let bundle = Bundle(url: Bundle.main.url(forResource: ApplicationResources.kFrameworkResourcesBundle, withExtension: "bundle")!)
            
            if bundle?.path(forResource: ApplicationXIBs.kPTFWInitialSetupView, ofType: "nib") != nil {
                print("exists")
            } else {
                print("not exist")
            }

            self.view.addSubview(initialSetupViewController.view)
            self.addChildViewController(initialSetupViewController)
            
            initialSetupViewController.didMove(toParentViewController: self)
        }
    }
    
    // MARK: Close SDK Event
    private func handleBackButtonTapEvent() {
        self.initialSetupViewController.willMove(toParentViewController: self)
        self.initialSetupViewController.view.removeFromSuperview()
        self.initialSetupViewController.removeFromParentViewController()
    }
    
    // MARK: Close Response window Event
    private func handleCloseResponseViewTapEvent() {
        self.launcherView.responseView.isHidden = true
    }
    
    
}


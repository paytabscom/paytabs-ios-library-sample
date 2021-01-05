//
//  ViewController.swift
//  sample
//
//  Created by Ramy Sabry on 10/14/19.
//  Copyright © 2019 Paytabs. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    var initialSetupViewController: PTFWInitialSetupViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let applePayButton = PKPaymentButton.init(paymentButtonType: .buy, paymentButtonStyle: .whiteOutline)
        applePayButton.addTarget(self, action: #selector(applePayTap), for: .touchUpInside)
        stackView.addArrangedSubview(applePayButton)
    }

    @IBAction func setOnClickPay(_ sender: Any) {
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
            andWithMerchantSecretKey: "kuTEjyEMhpVSWTwXBSOSeiiDAeMCOdyeuFZKiXAlhzjSKqswUWAgbCaYFivjvYzCWaWJbRszhjZuEQqsUycVzLSyMIaZiQLlRqlp",
            andWithMerchantRegion: "emirates",
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
    }
    
    @objc func applePayTap() {
        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(applePayWith: bundle, andWithViewFrame: view.frame, andWithAmount: 1.0, andWithCustomerTitle: "Pay With Apple Pay", andWithCurrencyCode: "AED", andWithCountryCode: "AE", andForceShippingInfo: false, andWithSDKLanguage: "en", andWithOrderID: "123456", andIsTokenization: true, andIsPreAuth: false, andWithMerchantEmail: "test@example.com", andWithMerchantSecretKey: "kuTEjyEMhpVSWTwXBSOSeiiDAeMCOdyeuFZKiXAlhzjSKqswUWAgbCaYFivjvYzCWaWJbRszhjZuEQqsUycVzLSyMIaZiQLlRqlp", andWithMerchantApplePayIdentifier: "merchant.bundleId", andWithSupportedNetworks: [.visa, .masterCard, .amex], andWithMerchantRegion: "emirates", andWithAssigneeCode: "SDK")

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
        
    }
}


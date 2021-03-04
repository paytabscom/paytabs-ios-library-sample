//
//  ViewController.swift
//  Sample
//
//  Created by Mohamed Adly on 10/11/20.
//

import UIKit
import PaymentSDK
import PassKit

class ViewController: UIViewController {
    private let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .whiteOutline)
    @IBOutlet private weak var buttonStackView: UIStackView!
    @IBOutlet private weak var payButtons: UIButton! {
        didSet{
            payButtons.layer.cornerRadius = 6
            payButtons.layer.borderWidth = 0.5
            payButtons.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    override func viewDidLoad() {
        self.title = "ClickPay Sample"
        super.viewDidLoad()
        applePayButton.addTarget(self, action: #selector(payWithApplePay), for: .touchUpInside)
        buttonStackView.addArrangedSubview(applePayButton)
    }
    
    let profileID = "your profile id"
    let serverKey = "server key"
    let clientKey = "client key"
    
    var billingDetails: PaymentSDKBillingDetails! {
        return PaymentSDKBillingDetails(name: "Mohamed Adly",
                                     email: "email@test.com",
                                     phone: "+2011111111",
                                     addressLine: "Street1",
                                     city: "Cairo",
                                     state: "Cairo",
                                     countryCode: "eg",
                                     zip: "12345")
    }
    
    var shippingDetails: PaymentSDKShippingDetails! {
        return PaymentSDKShippingDetails(name: "Mohamed Adly",
                                      email: "email@test.com",
                                      phone: "+201111111",
                                      addressLine: "Street1",
                                      city: "Cairo",
                                      state: "Cairo",
                                      countryCode: "eg",
                                      zip: "12345")
    }
    var configuration: PaymentSDKConfiguration! {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        
        return PaymentSDKConfiguration(profileID: profileID,
                                    serverKey: serverKey,
                                    clientKey: clientKey,
                                    cartID: "12345",
                                    currency: "AED",
                                    amount: 5.0,
                                    cartDescription: "Flowers",
                                    merchantCountryCode: "AE",
                                    showBillingInfo: false,
                                    screenTitle: "Pay with Card",
                                    billingDetails: billingDetails,
                                    theme: theme)
    }
    
    var applePayConfiguration: PaymentSDKConfiguration! {
        return PaymentSDKConfiguration(profileID: profileID,
                                    serverKey: serverKey,
                                    clientKey: clientKey,
                                    cartID: "12345",
                                    currency: "AED",
                                    amount: 5.0,
                                    merchantName: "Flowers Store",
                                    cartDescription: "Flowers",
                                    merchantCountryCode: "AE",
                                    merchantIdentifier: "merchant.com.bundleID",
                                    paymentNetworks: nil,
                                    forceShippingInfo: false,
                                    billingDetails: billingDetails)
    }
    
    @IBAction func pay() {
        PaymentSDK.startCardPayment(on: self, configuration: configuration,
                                 delegate: self)
    }
    
    @IBAction func payWithApplePay() {
        PaymentSDK.startApplePayPayment(on: self,
                                     configuration: applePayConfiguration,
                                     delegate: self)
    }
    func showError(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController.init(title: self.title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ViewController: PaymentSDKDelegate {
    
    func paymentSDK(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
        } else if let error = error {
            showError(message: error.localizedDescription)
        }
    }
}

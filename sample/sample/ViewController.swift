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
    @IBOutlet private weak var payWithCardButton: UIButton! {
        didSet{
            decorateButton(button: payWithCardButton)
        }
    }
    
    @IBOutlet private weak var payWithSTCPayButton: UIButton! {
        didSet{
            decorateButton(button: payWithSTCPayButton)
        }
    }
    
    @IBOutlet private weak var payWithValuButton: UIButton! {
        didSet{
            decorateButton(button: payWithValuButton)
        }
    }
    
    @IBOutlet private weak var payWithKnetButton: UIButton! {
        didSet{
            decorateButton(button: payWithKnetButton)
        }
    }
    
    @IBOutlet private weak var payWithFawryButton: UIButton! {
        didSet{
            decorateButton(button: payWithFawryButton)
        }
    }
    
    private func decorateButton(button: UIButton) {
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        self.title = "PayTabs Sample"
        super.viewDidLoad()
        applePayButton.addTarget(self, action: #selector(payWithApplePay), for: .touchUpInside)
        buttonStackView.insertArrangedSubview(applePayButton, at: 1)
    }
    
    let profileID = "profile id"
    let serverKey = "server key"
    let clientKey = "client key"
    
    var billingDetails: PaymentSDKBillingDetails! {
        return PaymentSDKBillingDetails(name: "John Smith",
                                     email: "email@test.com",
                                     phone: "+97311111111",
                                     addressLine: "Street1",
                                     city: "Dubai",
                                     state: "Dubai",
                                     countryCode: "ae",
                                     zip: "12345")
    }
    
    var shippingDetails: PaymentSDKShippingDetails! {
        return PaymentSDKShippingDetails(name: "John Smith",
                                      email: "email@test.com",
                                      phone: "+9731111111",
                                      addressLine: "Street1",
                                      city: "Dubai",
                                      state: "Dubai",
                                      countryCode: "ae",
                                      zip: "12345")
    }
    var configuration: PaymentSDKConfiguration! {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "USD",
                                       amount: 5.0,
                                       merchantCountryCode: "AE")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .theme(theme)
            .billingDetails(billingDetails)
    }
    
    var applePayConfiguration: PaymentSDKConfiguration! {
        return PaymentSDKConfiguration(profileID: profileID,
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
            
    }
    
    var stcPayConfiguration: PaymentSDKConfiguration! {
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "SAR",
                                       amount: 5.0,
                                       merchantCountryCode: "SA")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .billingDetails(billingDetails)
            .addAlternativePaymentMethod(.stcPay)
            
    }
    
    var valuConfiguration: PaymentSDKConfiguration! {
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "EGP",
                                       amount: 1000.0,
                                       merchantCountryCode: "eg")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .billingDetails(billingDetails)
            .addAlternativePaymentMethod(.valu)
            
    }
    
    var knetDebitConfiguration: PaymentSDKConfiguration! {
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "KWD",
                                       amount: 5.0,
                                       merchantCountryCode: "kw")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .billingDetails(billingDetails)
            .addAlternativePaymentMethod(.knetDebit)
            
    }
    
    var fawryConfiguration: PaymentSDKConfiguration! {
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "EGP",
                                       amount: 5.0,
                                       merchantCountryCode: "eg")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .billingDetails(billingDetails)
            .addAlternativePaymentMethod(.fawry)
            
    }
    
    @IBAction func pay() {
        PaymentManager.startCardPayment(on: self, configuration: configuration,
                                 delegate: self)
    }
    
    @IBAction func payWithApplePay() {
        PaymentManager.startApplePayPayment(on: self,
                                     configuration: applePayConfiguration,
                                     delegate: self)
    }
    
    @IBAction func payWithSTCPay() {
        PaymentManager.startAlternativePaymentMethod(on: self,
                                     configuration: stcPayConfiguration,
                                     delegate: self)
    }
    
    @IBAction func payWithValu() {
        PaymentManager.startAlternativePaymentMethod(on: self,
                                     configuration: valuConfiguration,
                                     delegate: self)
    }
    
    @IBAction func payWithKnetDebit() {
        PaymentManager.startAlternativePaymentMethod(on: self,
                                     configuration: knetDebitConfiguration,
                                     delegate: self)
    }
    
    @IBAction func payWithFawry() {
        PaymentManager.startAlternativePaymentMethod(on: self,
                                     configuration: valuConfiguration,
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

extension ViewController: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
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

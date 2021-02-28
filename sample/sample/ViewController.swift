//
//  ViewController.swift
//  Sample
//
//  Created by Mohamed Adly on 10/11/20.
//

import UIKit
import PayTabs
import PassKit

class ViewController: UIViewController {
    private let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .whiteOutline)
    @IBOutlet private weak var buttonStackView: UIStackView!
    @IBOutlet private weak var paytabsButtons: UIButton! {
        didSet{
            paytabsButtons.layer.cornerRadius = 6
            paytabsButtons.layer.borderWidth = 0.5
            paytabsButtons.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    override func viewDidLoad() {
        self.title = "PayTabs Sample"
        super.viewDidLoad()
        applePayButton.addTarget(self, action: #selector(payWithApplePay), for: .touchUpInside)
        buttonStackView.addArrangedSubview(applePayButton)
    }
    
    let profileID = "your profile id"
    let serverKey = "server key"
    let clientKey = "client key"
    
    var billingDetails: PayTabsBillingDetails! {
        return PayTabsBillingDetails(name: "Mohamed Adly",
                                     email: "email@test.com",
                                     phone: "+2011111111",
                                     addressLine: "Street1",
                                     city: "Cairo",
                                     state: "Cairo",
                                     countryCode: "eg",
                                     zip: "12345")
    }
    
    var shippingDetails: PayTabsShippingDetails! {
        return PayTabsShippingDetails(name: "Mohamed Adly",
                                      email: "email@test.com",
                                      phone: "+201111111",
                                      addressLine: "Street1",
                                      city: "Cairo",
                                      state: "Cairo",
                                      countryCode: "eg",
                                      zip: "12345")
    }
    var configuration: PayTabsConfiguration! {
        let theme = PayTabsTheme.default
        theme.logoImage = UIImage(named: "Logo")
        
        return PayTabsConfiguration(profileID: profileID,
                                    serverKey: serverKey,
                                    clientKey: clientKey,
                                    cartID: "12345",
                                    currency: "AED",
                                    amount: 5.0,
                                    cartDescription: "Flowers",
                                    merchantCountryCode: "AE",
                                    showBillingInfo: true,
                                    screenTitle: "Pay with Card",
                                    billingDetails: billingDetails,
                                    theme: theme)
    }
    
    var applePayConfiguration: PayTabsConfiguration! {
        return PayTabsConfiguration(profileID: profileID,
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
        PayTabs.startCardPayment(on: self, configuration: configuration,
                                 delegate: self)
    }
    
    @IBAction func payWithApplePay() {
        PayTabs.startApplePayPayment(on: self,
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

extension ViewController: PayTabsPaymentDelegate {
    func paytabs(didFinishTransaction transactionDetails: PayTabsTransactionDetails?, error: Error?) {
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

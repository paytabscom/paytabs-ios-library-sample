//
//  PaymentConfiguration.swift
//  sample-swiftui
//
//  Created by Amr Magdy on 17/12/2023.
//

import Foundation
import PaymentSDK
import UIKit

extension UIColor {
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}

class PaymentConfiguration {
    static let profileID = "100181"
    static let serverKey = "SRJNGJBG2D-JDRGZTMJBB-LHLJJBZJLB"
    static let clientKey = "CBKMN9-Q2GP6D-RT97N6-72HNHM"
    static let defaultCurrency = "EGP"
    static let defaultAmount: Double = 1.0
    static let defaultMerchantCountryCode = "EG"
    static let defaultMerchantName = "Your Store Name"
    static let defaultMerchantAppleBundleID = "merchant.com.paytabs.applepay"
    
    static var billingDetails: PaymentSDKBillingDetails! {
        return PaymentSDKBillingDetails(name: "John Smith",
                                        email: "email@test.com",
                                        phone: "+97311111111",
                                        addressLine: "Street1",
                                        city: "Dubai",
                                        state: "Dubai",
                                        countryCode: "ae",
                                        zip: "12345")
    }
    
    static var shippingDetails: PaymentSDKShippingDetails! {
        return PaymentSDKShippingDetails(name: "John Smith",
                                         email: "email@test.com",
                                         phone: "+9731111111",
                                         addressLine: "Street1",
                                         city: "Dubai",
                                         state: "Dubai",
                                         countryCode: "ae",
                                         zip: "12345")
    }
    static var configuration: PaymentSDKConfiguration! {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        theme.backgroundColor = .dynamic(light: .white, dark: .black)
        theme.inputFieldBackgroundColor = .dynamic(light: .white, dark: UIColor(white: 0.15, alpha: 1.0))
        theme.primaryFontColor = .dynamic(light: .black, dark: .white)
        theme.secondaryFontColor = .dynamic(light: .black, dark: .white)
        theme.titleFontColor = .dynamic(light: .black, dark: .white)
        theme.placeholderColor = .dynamic(light: .darkGray, dark: .lightGray)
        theme.buttonColor = .dynamic(light: .systemBlue, dark: .systemBlue)
        theme.buttonFontColor = .dynamic(light: .white, dark: .white)
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: defaultCurrency,
                                       amount: defaultAmount,
                                       merchantCountryCode: defaultMerchantCountryCode)
        .cartDescription("Flowers")
        .cartID("1234")
        .screenTitle("Pay with Card")
        .theme(theme)
        .billingDetails(billingDetails)
    }
}

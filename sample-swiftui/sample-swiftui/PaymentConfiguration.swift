//
//  PaymentConfiguration.swift
//  sample-swiftui
//
//  Created by Amr Magdy on 17/12/2023.
//

import Foundation
import PaymentSDK
import UIKit

class PaymentConfiguration {
    static let profileID = "profile id"
    static let serverKey = "server key"
    static let clientKey = "client key"
    static let defaultCurrency = "AED"
    static let defaultAmount: Double = 5.0
    static let defaultMerchantCountryCode = "AE"
    
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

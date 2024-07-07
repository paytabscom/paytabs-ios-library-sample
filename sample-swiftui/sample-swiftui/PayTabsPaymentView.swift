//
//  ContentView.swift
//  sample-swiftui
//
//  Created by Amr Magdy on 17/12/2023.
//

import SwiftUI
import PaymentSDK
import UIKit

struct PayTabsPaymentView: View {
 
    var body: some View {
        
        Button(NSLocalizedString("welcome_screen_title", comment: "")) {
            print(NSLocalizedString("welcome_screen_title", comment: ""))
                  
            guard let topVC = getTOPVC() else { return }
            PaymentManager.startCardPayment(on: topVC, configuration: PaymentConfiguration.configuration, delegate: PaymentDelegate())
        }
    }
    
    /// Returns the topmost view controller in the application's view hierarchy.
    ///
    /// - Returns: The topmost view controller, or `nil` if not found.
    func getTOPVC() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}

class PaymentDelegate: NSObject, PaymentManagerDelegate {
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDK.PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
            if transactionDetails.isSuccess() {
                print("Successful transaction")
            }
        } else if let error = error {
            print("Error: \(error.localizedDescription)")
        }
    }
}



struct PayTabsPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PayTabsPaymentView()
    }
}

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
    @State private var amount: String = String(PaymentConfiguration.defaultAmount)
    @State private var currency: String = PaymentConfiguration.defaultCurrency
    /// Selected merchant country code (used for `merchantCountryCode` in configuration).
    @State private var merchantCountryCode: String = PaymentConfiguration.defaultMerchantCountryCode
    private let availableCurrencies: [String] = ["AED", "SAR", "USD", "EGP"]
    /// Country dropdown options: show full country name, send ISO2 code.
    private let availableCountries: [(name: String, code: String)] = [
        ("United Arab Emirates", "AE"),
        ("Saudi Arabia", "SA"),
        ("Kuwait", "KW"),
        ("Egypt", "EG"),
        ("United States", "US"),
        ("Qatar", "QA"),
        ("Bahrain", "BH"),
        ("Oman", "OM")
    ]
    // Credentials
    @State private var profileIdInput: String = PaymentConfiguration.profileID
    @State private var serverKeyInput: String = PaymentConfiguration.serverKey
    @State private var clientKeyInput: String = PaymentConfiguration.clientKey

    // Billing
    @State private var billName: String = PaymentConfiguration.billingDetails.name ?? ""
    @State private var billEmail: String = PaymentConfiguration.billingDetails.email ?? ""
    @State private var billPhone: String = PaymentConfiguration.billingDetails.phone ?? ""
    @State private var billAddress: String = PaymentConfiguration.billingDetails.addressLine ?? ""
    @State private var billCity: String = PaymentConfiguration.billingDetails.city ?? ""
    @State private var billState: String = PaymentConfiguration.billingDetails.state ?? ""
    @State private var billCountry: String = PaymentConfiguration.billingDetails.countryCode ?? ""
    @State private var billZip: String = PaymentConfiguration.billingDetails.zip ?? ""

    // Shipping
    @State private var shipName: String = PaymentConfiguration.shippingDetails.name ?? ""
    @State private var shipEmail: String = PaymentConfiguration.shippingDetails.email ?? ""
    @State private var shipPhone: String = PaymentConfiguration.shippingDetails.phone ?? ""
    @State private var shipAddress: String = PaymentConfiguration.shippingDetails.addressLine ?? ""
    @State private var shipCity: String = PaymentConfiguration.shippingDetails.city ?? ""
    @State private var shipState: String = PaymentConfiguration.shippingDetails.state ?? ""
    @State private var shipCountry: String = PaymentConfiguration.shippingDetails.countryCode ?? ""
    @State private var shipZip: String = PaymentConfiguration.shippingDetails.zip ?? ""

    enum PaymentMethod: String, CaseIterable, Identifiable {
        case card = "Card"
        case applePay = "Apple Pay"
        case stcPay = "STC Pay"
        var id: String { rawValue }
    }

    @State private var selectedMethod: PaymentMethod = .card
    @State private var showBilling: Bool = false
    @State private var showShipping: Bool = false
    @State private var isPaying: Bool = false
    @State private var errorMessage: String?
    @State private var showReceipt: Bool = false
    @State private var receiptText: String = ""
    @State private var paymentDelegate: PaymentDelegate?
 
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker("Currency", selection: $currency) {
                        ForEach(availableCurrencies, id: \.self) { code in
                            Text(code).tag(code)
                        }
                    }
                    .pickerStyle(.menu)
                    // Single dropdown to pick merchant country code.
                    Picker("Merchant Country", selection: $merchantCountryCode) {
                        ForEach(availableCountries, id: \.code) { country in
                            Text(country.name).tag(country.code)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section(header: Text("Credentials")) {
                    Text("Profile ID").font(.subheadline)
                    TextField("", text: $profileIdInput)
                        .textFieldStyle(.roundedBorder)
                    Text("Server Key").font(.subheadline)
                    SecureField("", text: $serverKeyInput)
                        .textFieldStyle(.roundedBorder)
                    Text("Client Key").font(.subheadline)
                    SecureField("", text: $clientKeyInput)
                        .textFieldStyle(.roundedBorder)
                }
                Section (){
                    Toggle("Show Billing Details", isOn: $showBilling)
                }
                 if showBilling {
                Section(header: Text("Billing")) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Full name").font(.subheadline)
                            TextField("", text: $billName)
                                .textInputAutocapitalization(.words)
                                .textFieldStyle(.roundedBorder)
                            Text("Email").font(.subheadline)
                            TextField("", text: $billEmail)
                                .keyboardType(.emailAddress)
                                .textFieldStyle(.roundedBorder)
                            Text("Phone").font(.subheadline)
                            TextField("", text: $billPhone)
                                .keyboardType(.phonePad)
                                .textFieldStyle(.roundedBorder)
                            Text("Address").font(.subheadline)
                            TextField("", text: $billAddress)
                                .textFieldStyle(.roundedBorder)
                            Text("City").font(.subheadline)
                            TextField("", text: $billCity)
                                .textFieldStyle(.roundedBorder)
                            Text("State").font(.subheadline)
                            TextField("", text: $billState)
                                .textFieldStyle(.roundedBorder)
                            Picker("Country", selection: $billCountry) {
                                ForEach(availableCountries, id: \.code) { country in
                                    Text(country.name).tag(country.code)
                                }
                            }
                            .pickerStyle(.menu)
                            Text("ZIP").font(.subheadline)
                            TextField("", text: $billZip)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }
                Section (){
                    Toggle("Show Shipping Details", isOn: $showShipping)
                }
                if showShipping {

                Section(header: Text("Shipping")) {
                   
                    
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Full name").font(.subheadline)
                            TextField("", text: $shipName)
                                .textInputAutocapitalization(.words)
                                .textFieldStyle(.roundedBorder)
                            Text("Email").font(.subheadline)
                            TextField("", text: $shipEmail)
                                .keyboardType(.emailAddress)
                                .textFieldStyle(.roundedBorder)
                            Text("Phone").font(.subheadline)
                            TextField("", text: $shipPhone)
                                .keyboardType(.phonePad)
                                .textFieldStyle(.roundedBorder)
                            Text("Address").font(.subheadline)
                            TextField("", text: $shipAddress)
                                .textFieldStyle(.roundedBorder)
                            Text("City").font(.subheadline)
                            TextField("", text: $shipCity)
                                .textFieldStyle(.roundedBorder)
                            Text("State").font(.subheadline)
                            TextField("", text: $shipState)
                                .textFieldStyle(.roundedBorder)
                            Picker("Country", selection: $shipCountry) {
                                ForEach(availableCountries, id: \.code) { country in
                                    Text(country.name).tag(country.code)
                                }
                            }
                            .pickerStyle(.menu)
                            Text("ZIP").font(.subheadline)
                            TextField("", text: $shipZip)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }

                Section(header: Text("Payment Method")) {
                    Picker("Select", selection: $selectedMethod) {
                        ForEach(PaymentMethod.allCases) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                    .pickerStyle(.segmented)
                    if selectedMethod == .applePay {
                        ApplePayButtonView {
                            startApplePay()
                        }
                        .frame(height: 44)
                    }
                }

                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage).foregroundColor(.red)
                    }
                }

                if selectedMethod != .applePay {
                    Section {
                        Button(action: startPayment) {
                            Text("Pay").fontWeight(.semibold)
                        }
                    }
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showReceipt) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Spacer()
                        Text("Receipt").font(.headline)
                        Spacer()
                    }
                    ScrollView {
                        Text(receiptText)
                            .font(.system(.body, design: .monospaced))
                            .padding(.horizontal)
                    }
                    Button(action: shareReceipt) {
                        HStack { Image(systemName: "square.and.arrow.up"); Text("Share Receipt") }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .onReceive(NotificationCenter.default.publisher(for: .ptPaymentFinished)) { notification in
                isPaying = false
                if let error = notification.userInfo?["error"] as? Error {
                    errorMessage = error.localizedDescription
                    return
                }
                let d = notification.userInfo?["details"] as? PaymentSDK.PaymentSDKTransactionDetails
                guard let details = d else {
                    errorMessage = "Unknown payment result"
                    return
                }
                var lines: [String] = []
                lines.append("=== Receipt ===")
                lines.append("Method: \(selectedMethod.rawValue)")
                lines.append("Amount: \(amount) \(currency)")
                lines.append("")
                lines.append("Billing:")
                lines.append("  Name: \(billName)")
                lines.append("  Email: \(billEmail)")
                lines.append("  Phone: \(billPhone)")
                lines.append("  Address: \(billAddress), \(billCity), \(billState), \(countryName(for: billCountry)) (\(billCountry.uppercased())) \(billZip)")
                if showShipping {
                    lines.append("")
                    lines.append("Shipping:")
                    lines.append("  Name: \(shipName)")
                    lines.append("  Email: \(shipEmail)")
                    lines.append("  Phone: \(shipPhone)")
                    lines.append("  Address: \(shipAddress), \(shipCity), \(shipState), \(countryName(for: shipCountry)) (\(shipCountry.uppercased())) \(shipZip)")
                }
                lines.append("")
                lines.append("Transaction:")
                lines.append("  Reference: \(details.transactionReference ?? "-")")
                lines.append("  Code: \(details.paymentResult?.responseCode ?? "-")")
                lines.append("  Message: \(details.paymentResult?.responseMessage ?? "-")")
                lines.append("  Time: \(details.paymentResult?.transactionTime ?? "-")")
                lines.append("  Status: \(details.isSuccess() ? "SUCCESS" : "FAILED")")
                receiptText = lines.joined(separator: "\n")
                showReceipt = true
            }
        }
    }

    private func makeBilling() -> PaymentSDKBillingDetails {
        PaymentSDKBillingDetails(name: billName,
                                 email: billEmail,
                                 phone: billPhone,
                                 addressLine: billAddress,
                                 city: billCity,
                                 state: billState,
                                 countryCode: billCountry.lowercased(),
                                 zip: billZip)
    }

    private func makeShipping() -> PaymentSDKShippingDetails {
        PaymentSDKShippingDetails(name: shipName,
                                  email: shipEmail,
                                  phone: shipPhone,
                                  addressLine: shipAddress,
                                  city: shipCity,
                                  state: shipState,
                                  countryCode: shipCountry.lowercased(),
                                  zip: shipZip)
    }

    /// Resolve display name from ISO2 code; falls back to uppercased code.
    private func countryName(for code: String) -> String {
        if let match = availableCountries.first(where: { $0.code.caseInsensitiveCompare(code) == .orderedSame }) {
            return match.name
        }
        return code.uppercased()
    }

    private func makeConfig() -> PaymentSDKConfiguration? {
        guard let amt = Double(amount) else {
            errorMessage = "Invalid amount"
            return nil
        }

        let theme = makeTheme()

        let cfg = PaymentSDKConfiguration(profileID: profileIdInput.trimmingCharacters(in: .whitespacesAndNewlines),
                                           serverKey: serverKeyInput.trimmingCharacters(in: .whitespacesAndNewlines),
                                           clientKey: clientKeyInput.trimmingCharacters(in: .whitespacesAndNewlines),
                                           currency: currency,
                                           amount: amt,
                                           merchantCountryCode: merchantCountryCode)
            .cartDescription("Sample Order")
            .cartID(UUID().uuidString)
            .screenTitle("Pay with Card")
            .theme(theme)
            .billingDetails(makeBilling())

        cfg.showBillingInfo = showBilling
        cfg.showShippingInfo = showShipping
        cfg.forceShippingInfo = false

        // optional shipping
        if showShipping {
            cfg.shippingDetails = makeShipping()
        }
        return cfg
    }

    /// Theme used for all payment methods (card, Apple Pay, alternative payments).
    private func makeTheme() -> PaymentSDKTheme {
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
        return theme
    }

    /// Builds configuration for alternative payment methods (currently STC Pay only).
    private func makeAlternativeConfig(for method: PaymentMethod) -> PaymentSDKConfiguration? {
        guard let amt = Double(amount) else {
            errorMessage = "Invalid amount"
            return nil
        }

        let theme = makeTheme()

        // Build configuration per method (values mirror the UIKit sample).
        let baseProfileID = profileIdInput.trimmingCharacters(in: .whitespacesAndNewlines)
        let baseServerKey = serverKeyInput.trimmingCharacters(in: .whitespacesAndNewlines)
        let baseClientKey = clientKeyInput.trimmingCharacters(in: .whitespacesAndNewlines)

        switch method {
        case .stcPay:
            let cfg = PaymentSDKConfiguration(profileID: baseProfileID,
                                              serverKey: baseServerKey,
                                              clientKey: baseClientKey,
                                              currency: "SAR",
                                              amount: amt,
                                              merchantCountryCode: "SA")
                .cartDescription("Sample Order")
                .cartID(UUID().uuidString)
                .screenTitle(method.rawValue)
                .theme(theme)
                .billingDetails(makeBilling())
                .addAlternativePaymentMethod(.stcPay)
            cfg.showBillingInfo = showBilling
            cfg.showShippingInfo = showShipping
            cfg.forceShippingInfo = false

            if showShipping {
                cfg.shippingDetails = makeShipping()
            }
            return cfg

        case .card, .applePay:
            // Should not be called for these.
            return nil
        }
    }

    private func startPayment() {
        errorMessage = nil
        guard let topVC = getTOPVC() else { return }
        // For card and Apple Pay we use the standard configuration,
        // for alternative payments we build a specific configuration.

        switch selectedMethod {
        case .card:
            guard let configuration = makeConfig() else { return }
            let del = PaymentDelegate()
            paymentDelegate = del
            PaymentManager.startCardPayment(on: topVC, configuration: configuration, delegate: del)

        case .applePay:
            guard let configuration = makeConfig() else { return }
            // Requires proper Apple Pay setup; set merchant fields before starting
            configuration.merchantName("Your Store Name")
            configuration.merchantAppleBundleID("merchant.com.your.bundle")
            let del = PaymentDelegate()
            paymentDelegate = del
            PaymentManager.startApplePayPayment(on: topVC, configuration: configuration, delegate: del)

        case .stcPay:
            guard let altConfig = makeAlternativeConfig(for: selectedMethod) else { return }
            let del = PaymentDelegate()
            paymentDelegate = del
            PaymentManager.startAlternativePaymentMethod(on: topVC, configuration: altConfig, delegate: del)
        }
        // No loader UI
    }

    private func startApplePay() {
        errorMessage = nil
        guard let topVC = getTOPVC() else { return }
        guard let configuration = makeConfig() else { return }
        configuration.merchantName("Your Store Name")
        configuration.merchantAppleBundleID("merchant.com.your.bundle")
        let del = PaymentDelegate()
        paymentDelegate = del
        PaymentManager.startApplePayPayment(on: topVC, configuration: configuration, delegate: del)
    }

    private func shareReceipt() {
        guard !receiptText.isEmpty else { return }
        guard let topVC = getTOPVC() else { return }
        let activity = UIActivityViewController(activityItems: [receiptText], applicationActivities: nil)
        topVC.present(activity, animated: true)
    }

    /// Returns the topmost view controller in the application's view hierarchy.
    ///
    /// - Returns: The topmost view controller, or `nil` if not found.
    func getTOPVC() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first

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
        NotificationCenter.default.post(name: .ptPaymentFinished, object: nil, userInfo: ["details": transactionDetails as Any, "error": error as Any])
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

// Native Apple Pay button for SwiftUI
import PassKit
struct ApplePayButtonView: UIViewRepresentable {
    let action: () -> Void
    func makeUIView(context: Context) -> PKPaymentButton {
        let button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.tapped), for: .touchUpInside)
        return button
    }
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(action: action) }
    class Coordinator: NSObject {
        let action: () -> Void
        init(action: @escaping () -> Void) { self.action = action }
        @objc func tapped() { action() }
    }
}

extension Notification.Name {
    static let ptPaymentFinished = Notification.Name("PTPaymentFinished")
}

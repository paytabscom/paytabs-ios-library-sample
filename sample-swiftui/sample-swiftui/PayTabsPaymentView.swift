//
//  ContentView.swift
//  sample-swiftui
//
//  Created by Amr Magdy on 17/12/2023.
//

import SwiftUI
import PaymentSDK
import UIKit
import PassKit

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
    @State private var merchantNameInput: String = PaymentConfiguration.defaultMerchantName
    @State private var merchantAppleBundleIdInput: String = PaymentConfiguration.defaultMerchantAppleBundleID

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
    @State private var selectedApplePayNetwork: PKPaymentNetwork?
    @State private var showBilling: Bool = false
    @State private var showShipping: Bool = false
    @State private var selectedLanguage: String = "en"
    @State private var isPaying: Bool = false
    @State private var errorMessage: String?
    @State private var showReceipt: Bool = false
    @State private var receiptText: String = ""
    @State private var paymentDelegate: PaymentDelegate?
    
    // Apple Pay specific features (matching iOS SDK sample)
    @State private var simplifyApplePayValidation: Bool = true
    @State private var forceShippingInfo: Bool = false
    @State private var isDigitalProduct: Bool = false
    @State private var enableZeroContacts: Bool = false
    @State private var selectedPaymentNetworks: Set<PKPaymentNetwork> = []
    
    private let availableLanguages: [(name: String, code: String)] = [
        ("English", "en"),
        ("Arabic", "ar"),
        ("Urdu", "ur"),
        ("Turkish", "tr"),
        ("French", "fr")
    ]
 
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
                Section(header: Text("Language")) {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(availableLanguages, id: \.code) { language in
                            Text(language.name).tag(language.code)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: selectedLanguage) { newLanguage in
                        // Save locale immediately when language changes
                        saveLanguageCode(newLanguage)
                    }
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
                    Text("Apple Pay Merchant Name").font(.subheadline)
                    TextField("", text: $merchantNameInput)
                        .textFieldStyle(.roundedBorder)
                    Text("Apple Pay Merchant ID").font(.subheadline)
                    TextField("", text: $merchantAppleBundleIdInput)
                        .textFieldStyle(.roundedBorder)
                }
                // Apple Pay Configuration Section (matching iOS SDK sample)
                if selectedMethod == .applePay {
                    Section(header: Text("Apple Pay Options")) {
                        Toggle("Simplify Apple Pay Validation", isOn: $simplifyApplePayValidation)
                        Toggle("Force Shipping Info", isOn: $forceShippingInfo)
                        Toggle("Digital Product", isOn: $isDigitalProduct)
                        Toggle("Enable Zero Contacts", isOn: $enableZeroContacts)
                    }
                }
                
                Section (){
                    Toggle("Show Billing Details", isOn: $showBilling)
                    if selectedMethod == .applePay {
                        Toggle("Show Shipping Details", isOn: $showShipping)
                    }
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
                
                if selectedMethod == .applePay {
                    Section(header: Text("Apple Pay Network")) {
                        Picker("Network", selection: $selectedApplePayNetwork) {
                            Text("All Supported").tag(nil as PKPaymentNetwork?)
                            ForEach(availablePaymentNetworks, id: \.self) { network in
                                Text(displayName(for: network)).tag(network as PKPaymentNetwork?)
                            }
                        }
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
            .onAppear {
                // Save initial locale when view appears
                saveLanguageCode(selectedLanguage)
            }
            .onReceive(NotificationCenter.default.publisher(for: .ptPaymentValidationError)) { notification in
                isPaying = false
                if let error = notification.userInfo?["error"] as? Error {
                    print("❌ [SwiftUI] Received validation error: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                } else {
                    print("❌ [SwiftUI] Received validation error but no error object")
                    errorMessage = "Apple Pay validation failed. Please check your configuration."
                }
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
            .languageCode(selectedLanguage)

        cfg.showBillingInfo = showBilling
        cfg.showShippingInfo = showShipping
        // Apply Apple Pay specific settings if Apple Pay is selected
        if selectedMethod == .applePay {
            cfg.forceShippingInfo = forceShippingInfo
            cfg.isDigitalProduct = isDigitalProduct
            cfg.enableZeroContacts = enableZeroContacts
        } else {
            cfg.forceShippingInfo = false
        }

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
            // Save locale before starting payment
            saveLanguageCode(selectedLanguage)
            let del = PaymentDelegate()
            paymentDelegate = del
            PaymentManager.startCardPayment(on: topVC, configuration: configuration, delegate: del)

        case .applePay:
            // CRITICAL: Save locale FIRST before creating configuration
            // This ensures SDK error messages are localized correctly
            saveLanguageCode(selectedLanguage)
            
            guard let configuration = makeConfig() else { return }
            // Apply all Apple Pay configuration (matching iOS SDK sample)
            configuration.merchantName(merchantNameInput.trimmingCharacters(in: .whitespacesAndNewlines))
            // Normalize merchant ID to lowercase (Apple Pay merchant IDs are case-sensitive and should be lowercase)
            configuration.merchantAppleBundleID(merchantAppleBundleIdInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            applyDefaultApplePayNetworksIfNeeded(on: configuration)
            configuration.simplifyApplePayValidation = simplifyApplePayValidation
            configuration.forceShippingInfo = forceShippingInfo
            configuration.isDigitalProduct = isDigitalProduct
            configuration.enableZeroContacts = enableZeroContacts
            configuration.languageCode = selectedLanguage
            
            // Save again to ensure it's set (SDK will also save it, but we do it early)
            saveLanguageCode(selectedLanguage)
            
            let del = PaymentDelegate()
            paymentDelegate = del
            PaymentManager.startApplePayPayment(on: topVC, configuration: configuration, delegate: del)

        case .stcPay:
            guard let altConfig = makeAlternativeConfig(for: selectedMethod) else { return }
            altConfig.languageCode = selectedLanguage
            saveLanguageCode(selectedLanguage)
            let del = PaymentDelegate()
            paymentDelegate = del
            PaymentManager.startAlternativePaymentMethod(on: topVC, configuration: altConfig, delegate: del)
        }
        // No loader UI
    }

    private func startApplePay() {
        errorMessage = nil
        isPaying = true
        
        print("🍎 [Apple Pay] Starting Apple Pay flow...")
        
        // CRITICAL: Save locale FIRST before creating configuration
        // This ensures SDK error messages are localized correctly
        saveLanguageCode(selectedLanguage)
        
        guard let topVC = getTOPVC() else {
            print("❌ [Apple Pay] Failed to get top view controller")
            errorMessage = "Failed to get view controller"
            isPaying = false
            return
        }
        
        guard let configuration = makeConfig() else {
            print("❌ [Apple Pay] Failed to create configuration")
            isPaying = false
            return
        }
        
        // Apply all Apple Pay configuration (matching iOS SDK sample)
        let merchantName = merchantNameInput.trimmingCharacters(in: .whitespacesAndNewlines)
        // Normalize merchant ID to lowercase (Apple Pay merchant IDs are case-sensitive and should be lowercase)
        let merchantID = merchantAppleBundleIdInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        print("🍎 [Apple Pay] Merchant Name: '\(merchantName)'")
        print("🍎 [Apple Pay] Merchant ID: '\(merchantID)'")
        
        // Validate required fields
        if merchantID.isEmpty {
            print("❌ [Apple Pay] Merchant ID is empty")
            errorMessage = "Apple Pay Merchant ID is required. Please enter it in the Credentials section."
            isPaying = false
            return
        }
        
        if merchantName.isEmpty {
            print("❌ [Apple Pay] Merchant Name is empty")
            errorMessage = "Apple Pay Merchant Name is required. Please enter it in the Credentials section."
            isPaying = false
            return
        }
        
        configuration.merchantName(merchantName)
        configuration.merchantAppleBundleID(merchantID)
        applyDefaultApplePayNetworksIfNeeded(on: configuration)
        configuration.simplifyApplePayValidation = simplifyApplePayValidation
        configuration.forceShippingInfo = forceShippingInfo
        configuration.isDigitalProduct = isDigitalProduct
        configuration.enableZeroContacts = enableZeroContacts
        configuration.languageCode = selectedLanguage
        
        // Log network configuration
        if let networks = configuration.paymentNetworks {
            let networkNames = networks.map { displayName(for: $0) }.joined(separator: ", ")
            print("🍎 [Apple Pay] Payment Networks: \(networkNames)")
        } else {
            print("🍎 [Apple Pay] Payment Networks: (will use defaults)")
        }
        
        // Check if device can make payments with the selected networks
        // Only check if a specific network is selected (not "All Supported")
        if let selected = selectedApplePayNetwork {
            // User selected a specific network - check if device supports it
            print("🍎 [Apple Pay] Checking specific network: \(displayName(for: selected))")
            if !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [selected]) {
                let networkName = displayName(for: selected)
                print("❌ [Apple Pay] Device cannot make payments with \(networkName)")
                errorMessage = "Apple Pay is not available with \(networkName) on this device. Please add a \(networkName) card in Wallet or select 'All Supported' networks."
                isPaying = false
                return
            }
            print("✅ [Apple Pay] Device supports \(displayName(for: selected))")
        } else {
            // "All Supported" selected - check if device can make payments at all
            print("🍎 [Apple Pay] Checking if device can make payments (All Supported)")
            if !PKPaymentAuthorizationViewController.canMakePayments() {
                print("❌ [Apple Pay] Device cannot make payments")
                errorMessage = "Apple Pay is not available on this device. Please set up Apple Pay in Settings."
                isPaying = false
                return
            }
            print("✅ [Apple Pay] Device can make payments")
        }
        
        // Save again to ensure it's set (SDK will also save it, but we do it early)
        saveLanguageCode(selectedLanguage)
        
        print("🍎 [Apple Pay] Calling PaymentManager.startApplePayPayment...")
        let del = PaymentDelegate()
        paymentDelegate = del
        PaymentManager.startApplePayPayment(on: topVC, configuration: configuration, delegate: del)
        print("🍎 [Apple Pay] PaymentManager.startApplePayPayment called successfully")
    }
    
    /// Mirrors the iOS SDK sample logic: if no networks are set, use default Apple Pay networks
    private func applyDefaultApplePayNetworksIfNeeded(on configuration: PaymentSDKConfiguration) {
        // If user selected a specific network, use that
        if let selected = selectedApplePayNetwork {
            configuration.paymentNetworks = [selected]
            return
        }
        
        // If configuration already has networks, use them
        if let existingNetworks = configuration.paymentNetworks, !existingNetworks.isEmpty {
            return
        }
        
        // Otherwise, use default networks (matching iOS SDK sample)
        var defaultNetworks: [PKPaymentNetwork] = [.visa, .masterCard, .amex]
        if #available(iOS 12.1.1, *) {
            defaultNetworks.append(.mada)
        }
        configuration.paymentNetworks = defaultNetworks
    }
    
    /// All Apple Pay payment networks this app should support (matching iOS SDK sample)
    private var availablePaymentNetworks: [PKPaymentNetwork] {
        var networks = [PKPaymentNetwork]()
        
        networks.append(contentsOf: [.visa, .masterCard, .amex])
        
        if #available(iOS 12.1.1, *) {
            networks.append(.mada)
        }
        
        networks.append(.discover)
        networks.append(.privateLabel)
        
        if #available(iOS 9.2, *) {
            networks.append(.chinaUnionPay)
        }
        
        if #available(iOS 10.3, *) {
            networks.append(.carteBancaire)
        }
        
        if #available(iOS 11.0, *) {
            networks.append(.carteBancaires)
        }
        
        if #available(iOS 11.2, *) {
            networks.append(.cartesBancaires)
        }
        
        if #available(iOS 12.0, *) {
            networks.append(contentsOf: [.eftpos, .electron])
        }
        
        if #available(iOS 12.1.1, *) {
            networks.append(.elo)
        }
        
        if #available(iOS 10.3, *) {
            networks.append(.idCredit)
        }
        
        if #available(iOS 9.2, *) {
            networks.append(.interac)
        }
        
        if #available(iOS 10.1, *) {
            networks.append(.JCB)
        }
        
        if #available(iOS 12.0, *) {
            networks.append(.maestro)
        }
        
        if #available(iOS 10.3, *) {
            networks.append(.quicPay)
        }
        
        if #available(iOS 10.1, *) {
            networks.append(.suica)
        }
        
        if #available(iOS 12.0, *) {
            networks.append(.vPay)
        }
        
        if #available(iOS 14.0, *) {
            networks.append(contentsOf: [.barcode, .girocard])
        }
        
        return networks
    }
    
    /// Human-readable names for Apple Pay networks
    private func displayName(for network: PKPaymentNetwork) -> String {
        switch network {
        case .visa: return "Visa"
        case .masterCard: return "Mastercard"
        case .amex: return "American Express"
        case .mada: return "Mada"
        case .discover: return "Discover"
        case .privateLabel: return "Private Label"
        case .chinaUnionPay: return "China UnionPay"
        case .carteBancaire, .carteBancaires, .cartesBancaires: return "Cartes Bancaires"
        case .eftpos: return "EFTPOS"
        case .electron: return "Electron"
        case .elo: return "Elo"
        case .idCredit: return "ID Credit"
        case .interac: return "Interac"
        case .JCB: return "JCB"
        case .maestro: return "Maestro"
        case .quicPay: return "QUICPay"
        case .suica: return "Suica"
        case .vPay: return "V Pay"
        case .barcode: return "Barcode"
        case .girocard: return "Girocard"
        default: return "\(network)"
        }
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
            print("✅ Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("✅ Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("✅ Token: " + (transactionDetails.token ?? ""))
            print("✅ Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("✅ Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
            if transactionDetails.isSuccess() {
                print("✅ Successful transaction")
            }
        } else if let error = error {
            print("❌ Payment Error: \(error.localizedDescription)")
        }
    }
    
    // Handle validation errors (e.g., when selected network is not available, invalid configuration, etc.)
    @objc func paymentManager(didRecieveValidation error: Error?) {
        if let error = error {
            print("❌ Validation Error: \(error.localizedDescription)")
            // Post notification so SwiftUI view can display the error
            NotificationCenter.default.post(name: .ptPaymentValidationError, object: nil, userInfo: ["error": error])
        }
    }
    
    // Handle payment cancellation
    @objc func paymentManager(didCancelPayment error: Error?) {
        print("⚠️ Payment Cancelled")
        if let error = error {
            print("⚠️ Cancel Error: \(error.localizedDescription)")
        }
    }
    
    // Handle payment start (for debugging)
    @objc func paymentManager(didStartPaymentTransaction rootViewController: UIViewController) {
        print("🚀 Payment Started")
    }
}



struct PayTabsPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PayTabsPaymentView()
    }
}

// Native Apple Pay button for SwiftUI
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
    static let ptPaymentValidationError = Notification.Name("PTPaymentValidationError")
}

// MARK: - Helper Functions
/// Helper function to save language code to UserDefaults
/// Uses the same key as the SDK: "payment_sdk_language_code"
private func saveLanguageCode(_ code: String?) {
    UserDefaults.standard.setValue(code, forKey: "payment_sdk_language_code")
    // Force synchronize to ensure it's saved immediately
    UserDefaults.standard.synchronize()
    // Also set AppleLanguages for system-wide locale support (matching iOS SDK sample)
    if let code = code {
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

//
//  sample_swiftuiApp.swift
//  sample-swiftui
//
//  Created by Amr Magdy on 17/12/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // CRITICAL: Save default locale at app launch to ensure SDK error messages are localized
        // This is especially important when using the published package which may not have
        // the early locale saving fixes
        let defaultLanguage = UserDefaults.standard.string(forKey: "payment_sdk_language_code") ?? "en"
        UserDefaults.standard.setValue(defaultLanguage, forKey: "payment_sdk_language_code")
        UserDefaults.standard.set([defaultLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        return true
    }
}

@main
struct sample_swiftuiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PayTabsPaymentView()
            }
        }
    }
}

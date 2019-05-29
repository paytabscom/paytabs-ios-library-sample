//
//  AppDelegate.swift
//  sample-run
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    // MARK: Init
    func initWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: Private methods
    // MARK: Navigation Bar Appearance
    private func initializeAppNavigationBarAppearance(viewController: UIViewController) -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }
    
    // MARK: Public methods
    // MARK: Sample Run Root Navigation Stack
    public func moveToSetupViewController() {
        let launcherViewController = PTSRLauncherViewController(nibName: ApplicationXIBs.kPTSRLauncherView, bundle: nil)
        
        self.window?.rootViewController = self.initializeAppNavigationBarAppearance(viewController: launcherViewController)
    }
    
}

//
//  ViewController.swift
//  sample-run
//
//  Created by PayTabs LLC on 10/5/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

import Foundation
import UIKit

class PTSRLauncherView: UIView {
    // MARK: Outlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var merchantEmailTextField: UITextField!
    @IBOutlet weak var merchantSecretKeyTextField: UITextField!
    @IBOutlet weak var customerEmailTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var redThemeValue: UITextField!
    @IBOutlet weak var greenThemeValue: UITextField!
    @IBOutlet weak var bluehemeValue: UITextField!

    @IBOutlet weak var responseCodeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var customerEmailLabel: UILabel!
    @IBOutlet weak var customerPasswordLabel: UILabel!
    @IBOutlet weak var transactionStateLabel: UILabel!
    @IBOutlet weak var tokenValueLabel: UILabel!

    @IBOutlet weak var tokenizationSwitch: UISwitch!
    @IBOutlet weak var isLightTheme: UISwitch!
    @IBOutlet weak var isArabic: UISwitch!

    @IBOutlet weak var responseView: UIView!

    // MARK: Callbacks
    public var didPressHitTestRunButtonCallback : (() -> Void)?
    public var didPressResponseViewCloseButtonCallback : (() -> Void)?

    // MARK: Overriden methods
    override func awakeFromNib() {
        self.configureView()
    }
    
    // MARK: Private methods
    private func configureView() {
        self.amountTextField.setLeftPaddingPoints(CGFloat(10.0))
        self.amountTextField.layer.borderWidth  = (CGFloat(0.5))
        self.amountTextField.layer.borderColor = UIColor.white.cgColor
        
        self.merchantEmailTextField.setLeftPaddingPoints(CGFloat(10.0))
        self.merchantEmailTextField.layer.borderWidth  = (CGFloat(0.5))
        self.merchantEmailTextField.layer.borderColor = UIColor.white.cgColor

        self.merchantSecretKeyTextField.setLeftPaddingPoints(CGFloat(10.0))
        self.merchantSecretKeyTextField.layer.borderWidth  = (CGFloat(0.5))
        self.merchantSecretKeyTextField.layer.borderColor = UIColor.white.cgColor
        
        self.customerEmailTextField.setLeftPaddingPoints(CGFloat(10.0))
        self.customerEmailTextField.layer.borderWidth  = (CGFloat(0.5))
        self.customerEmailTextField.layer.borderColor = UIColor.white.cgColor
        
        self.currencyTextField.setLeftPaddingPoints(CGFloat(10.0))
        self.currencyTextField.layer.borderWidth  = (CGFloat(0.5))
        self.currencyTextField.layer.borderColor = UIColor.white.cgColor
        
        self.redThemeValue.setLeftPaddingPoints(CGFloat(10.0))
        self.redThemeValue.layer.borderWidth  = (CGFloat(0.5))
        self.redThemeValue.layer.borderColor = UIColor.white.cgColor
        
        self.greenThemeValue.setLeftPaddingPoints(CGFloat(10.0))
        self.greenThemeValue.layer.borderWidth  = (CGFloat(0.5))
        self.greenThemeValue.layer.borderColor = UIColor.white.cgColor

        self.bluehemeValue.setLeftPaddingPoints(CGFloat(10.0))
        self.bluehemeValue.layer.borderWidth  = (CGFloat(0.5))
        self.bluehemeValue.layer.borderColor = UIColor.white.cgColor

        self.responseView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        UITextField.appearance().tintColor = .white
    }
    
    // MARK: Action Methods
    @IBAction func hitTestRunButtonPressed(_ sender: AnyObject) {
        self.handleHitTestRunButtonTapEvent()
    }

    @IBAction func closeResponseViewRunButtonPressed(_ sender: AnyObject) {
        self.handleCloseResponseViewButtonTapEvent()
    }
    
    // MARK: Events
    private func handleHitTestRunButtonTapEvent() {
        if didPressHitTestRunButtonCallback != nil {
            didPressHitTestRunButtonCallback!()
        }
    }
    
    private func handleCloseResponseViewButtonTapEvent() {
        if didPressResponseViewCloseButtonCallback != nil {
            didPressResponseViewCloseButtonCallback!()
        }
    }
}

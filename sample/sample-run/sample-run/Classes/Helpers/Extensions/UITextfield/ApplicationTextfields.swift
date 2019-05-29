//
//  ApplicationButtons.swift
//  sample-run
//
//  Created by PayTabs LLC on 6/9/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UITextField {
    func configure(backgroundColor: UIColor, borderColor: UIColor, textColor: UIColor, borderWidth: CGFloat, corners:UIRectCorner, cornerRadius: CGFloat) -> Void {
        self.borderStyle = .roundedRect
        
        self.backgroundColor = backgroundColor
        
        self.textColor = textColor
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(10.0), height: self.frame.height))
        self.leftViewMode = .always

        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.frame = self.bounds
        self.layer.mask = mask
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

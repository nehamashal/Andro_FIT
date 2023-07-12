//
//  ExtensionUIView.swift
//  Fit Form Fix
//
//  Created by Rajni Bajaj on 22/06/23.
//

import Foundation
import UIKit
extension UIView {
    
    func addShadowGrey(cornerRadius : Float){
        self.layer.borderWidth = 0.0
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func simpleWhiteShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 50
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}



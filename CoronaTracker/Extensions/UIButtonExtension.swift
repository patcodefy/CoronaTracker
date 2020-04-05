//
//  UIButtonExtension.swift
//  CoronaTracker
//
//  Created by pat on 3/25/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    
    @IBInspectable var imageColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            self.setImageColor(color: newValue)
        }
    }
    
    func setImageColor(color: UIColor) {
        let origImage = self.imageView?.image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
    
}


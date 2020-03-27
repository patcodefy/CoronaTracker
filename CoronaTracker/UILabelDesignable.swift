//
//  UILabelDesignable.swift
//  CoronaTracker
//
//  Created by pat on 3/25/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit.UILabel
extension UILabel {

    @IBInspectable var labelRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

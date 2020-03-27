//
//  UIButtonDesignable.swift
//  CoronaTracker
//
//  Created by pat on 3/25/20.
//  Copyright © 2020 pat. All rights reserved.
//

import SwiftUI
@IBDesignable extension UIButton {

    @IBInspectable var buttonRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

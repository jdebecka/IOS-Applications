//
//  AddCurrencyView.swift
//  Bitcoint Price Tracker
//
//  Created by Julia Debecka on 05/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

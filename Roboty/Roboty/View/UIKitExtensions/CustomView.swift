//
//  MoreInfoView.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

@IBDesignable
class customIV: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

}

@IBDesignable
class customButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            
        }
    }
}

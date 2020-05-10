//
//  ButtonExtension.swift
//  Egg Timer
//
//  Created by Julia Debecka on 09/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

extension UIButton {
    
    func roundCorners() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}


extension UIView {
    func getGradientLayer(with colors: [CGColor], for locations: [NSNumber]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = self.frame
        gradientLayer.locations = locations
        
        return gradientLayer
    }
}



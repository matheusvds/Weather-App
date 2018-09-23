//
//  UILabel.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 23/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

enum FontWeight: String {
    case bold = "ProximaNova-Bold"
    case light = "ProximaNova-Light"
    case regular = "ProximaNova-Regular"
    case semibold = "ProximaNova-Semibold"
    
    var name: String {
        return self.rawValue
    }
}

extension UILabel {
    func setDefaultFont(size: CGFloat = 16, weight: FontWeight) {
        self.font = UIFont(name: weight.name, size: size)
    }
}

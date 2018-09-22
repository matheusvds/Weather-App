//
//  Assets.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

enum Assets: String {

    //Tabbar Icons
    case forecastTabbarIcon
    case todayTabbarIcon

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

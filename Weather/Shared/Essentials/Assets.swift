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
    case topSeparatorImage

    //Today ViewController Icons
        //Middle Icons
    case todayHumidityIcon
    case todayPrecipitationIcon
    case todayPressureIcon
    case todayWindDirectionIcon
    case todayWindSpeedIcon
        //Top Icon
    case todayLocationIcon
    case todayBrokenCloudsTopIcon
    case todayCleaySkyTopIcon
    case todayFewCloudsTopIcon
    case todayMistTopIcon
    case todayRainTopIcon
    case todayScatteredCloudsTopIcon
    case todayShowerRainTopIcon
    case todaySnowTopIcon
    case todayThunderstormTopIcon
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

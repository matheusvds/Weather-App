//
//  WeatherKind.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 23/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

enum WeatherKind: String {
    
    case clearSky = "01"
    case fewClouds = "02"
    case scatteredClouds = "03"
    case brokenClouds = "04"
    case showerRain = "09"
    case rain = "10"
    case thunderstorm = "11"
    case snow = "13"
    case mist = "50"
    case none = ""
    
    var imageView: UIImageView {
        return UIImageView(image: icon)
    }
    
    private var icon: UIImage? {
        switch self {
        case .clearSky:
            return Assets.todayCleaySkyTopIcon.image
        case .fewClouds:
            return Assets.todayFewCloudsTopIcon.image
        case .scatteredClouds:
            return Assets.todayScatteredCloudsTopIcon.image
        case .brokenClouds:
            return Assets.todayBrokenCloudsTopIcon.image
        case .showerRain:
            return Assets.todayShowerRainTopIcon.image
        case .rain:
            return Assets.todayRainTopIcon.image
        case .thunderstorm:
            return Assets.todayThunderstormTopIcon.image
        case .snow:
            return Assets.todayShowerRainTopIcon.image
        case .mist:
            return Assets.todayMistTopIcon.image
        case .none:
            return UIImage()
        }
    }
}

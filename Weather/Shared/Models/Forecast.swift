//
//  Forecast.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let list: [Weather]
}

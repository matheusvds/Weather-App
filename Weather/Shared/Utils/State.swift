//
//  State.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 25/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

enum State<T> {
    case loading
    case ready(T)
    case error(WeatherError)
}

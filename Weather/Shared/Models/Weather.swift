//
//  Weather.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let weather: [Information]
    let main: Main
    let wind: Wind
    let dt: Int
    let precipitation: Precipitation?
}

struct Precipitation: Codable {
    let value: Int?
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
}

struct Information: Codable {
    let main: String
    let description: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

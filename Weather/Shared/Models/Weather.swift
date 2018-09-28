//
//  Weather.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let weather: [WeatherInfo]
    let main: Main
    let wind: Wind
    let dt: Int
    let rain: Rain?
    let coord: Coord?
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

struct Rain: Codable {
    let volume: Double?
    
    enum CodingKeys: String, CodingKey {
        case volume = "3h"
    }
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
}

struct WeatherInfo: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

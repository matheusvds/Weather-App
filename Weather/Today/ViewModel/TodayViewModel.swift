//
//  TodayViewModel.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 23/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import UIKit

struct TodayViewModel {
    
    var humidity: String = "-"
    var windSpeed: String = "-"
    var windDirection: String = "-"
    var rainVolume: String = "-"
    var pressure: String = "-"
    var weatherInfo: String = "-"
    var weatherDescription: String = "-"
    var temperature: String = "-"
    var icon: UIImageView = UIImageView(frame: .zero)
    var date: Date = Date()
    
    init(with data: Weather) {
        self.windSpeed = self.format(speed: data.wind.speed)
        self.windDirection = self.format(direction: data.wind.deg)
        self.humidity = self.format(humidity: data.main.humidity)
        self.rainVolume = self.format(rainVolume: data.rain)
        self.pressure = self.format(pressure: data.main.pressure)
        self.weatherInfo = self.format(weatherInfo: data.weather)
        self.weatherDescription = self.format(weatherDescription: data.weather)
        self.temperature = self.format(temperature: data.main.temp, with: data.weather)
        self.date = self.format(date: data.dt)
        self.icon = find(iconIn: data.weather)
    }
    
    fileprivate func find(iconIn weatherInfo: [WeatherInfo]) -> UIImageView {
        let name = self.format(iconName: weatherInfo)
        guard let imageView = WeatherKind(rawValue: String(name.dropLast()))?.imageView else {
            return UIImageView(frame: .zero)
        }
        let isNight = name.lowercased().last == "n"
        imageView.tintColor = isNight ? .blueThemeColor : .yellowThemeColor
        
        return imageView
    }
    
    fileprivate func format(speed: Double) -> String {
        return "\(Int(speed*3.6)) km/h"
    }
    
    fileprivate func format(humidity: Int) -> String {
        return "\(humidity)%"
    }
    
    fileprivate func format(rainVolume: Rain?) -> String {
        guard let rain = rainVolume,
            let volume = rain.volume else {
                return "-"
        }
        return "\(volume) mm"
    }
    
    fileprivate func format(pressure: Double) -> String {
        return "\(Int(pressure)) hPa"
    }
    
    
    fileprivate func format(temperature: Double, with weatherInfo: [WeatherInfo]) -> String {
        return "\(Int(temperature)) °C | \(self.format(weatherInfo: weatherInfo))"
    }
    
    fileprivate func format(direction: Double) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((direction / 45).rounded()) % 8
        if index >= directions.count { return "-" }
        return "\(directions[index])"
    }
    
    fileprivate func format(date: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(date))
    }
    
    fileprivate func format(weatherInfo: [WeatherInfo]) -> String {
        guard let info = weatherInfo.first else { return "-" }
        return info.main
    }
    
    fileprivate func format(iconName weatherInfo: [WeatherInfo]) -> String {
        guard let info = weatherInfo.first else { return "" }
        return info.icon
    }
    
    fileprivate func format(weatherDescription: [WeatherInfo]) -> String {
        guard let info = weatherInfo.first else { return "-" }
        return info.description
    }
}

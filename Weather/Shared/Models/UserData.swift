//
//  UserData.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 28/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation


struct UserData {
    let location: (String, String)
    let temperature: String
    
    init(with weather: Weather) {
        self.location = (String(weather.coord.lat),  String(weather.coord.lon))
        self.temperature = String(weather.main.temp)
    }
    
    func toDictionary() -> [String : Any] {
        var dictionary = [String : Any]()
        
        dictionary["latitude"] = self.location.0
        dictionary["longitude"] = self.location.1
        dictionary["temperature"] = self.temperature
        
        return dictionary
    }
}

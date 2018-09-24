//
//  WeatherError.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 24/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import Moya

enum WeatherError: Error {
    case localization
    case internet
    case unkown
    
    public init(error: MoyaError) {
        switch error {
        case .underlying(let error as NSError, _):
            if error.code == -1009 {
                self = .internet
                return
            }
            self = .unkown
        default:
            self = .unkown
        }
    }
}

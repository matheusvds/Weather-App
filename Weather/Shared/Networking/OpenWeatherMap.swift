//
//  OpenWeatherMap.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import Moya

public typealias Location = (lat: String, lon: String)
public enum OpenWeatherMap {
    static fileprivate let apiKey = "ec4718acf29c48ebd3a2eb40852b27d4"

    case current(_ location: Location)
    case forecast(_ location: Location)
}

extension OpenWeatherMap: TargetType {
    public var baseURL: URL {
        let serverURL = Environment().configuration(PlistKey.ServerURL)
        return URL(string: "http://\(serverURL)/data/2.5")!
    }
    
    public var path: String {
        switch self {
        case .current: return "/weather"
        case .forecast: return "/forecast"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .current, .forecast: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .current(let lat, let lon):
            return makeTask(withParams: lat, lon)
        case .forecast(let lat, let lon):
            return makeTask(withParams: lat, lon)
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}


//MARK: - Helper methods
extension OpenWeatherMap {
    fileprivate func makeTask(withParams lat: String,_ lon: String) -> Task {
        let params = [
            "lat"   : lat,
            "lon"   : lon,
            "units" : "metric",
            "appid" : OpenWeatherMap.apiKey

        ]
        return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
}

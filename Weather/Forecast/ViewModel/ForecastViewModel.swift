//
//  BaseViewModel.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 27/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

//
//  TodayViewModel.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 23/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

struct ForecastViewModel {
    
    var forecast: [TodayViewModel] = []
    var errorViewImage: UIImage? = Assets.internetErrorImage.image
    var errorKind: WeatherError?
    var datesDictionary = [String: [String]]()
    
    lazy var sortedKeys: [String] = {
        self.sortedKeys(from: self.datesDictionary)
    }()
    
    lazy var weekDays: [String] = {
        var days = self.sortedKeys.compactMap({ String($0.split(separator: " ").first!) })
        days.remove(at: 0)
        days.insert("Today", at: 0)
        return days
    }()
    
    init(data: [Weather]) {
        self.forecast = data.compactMap({ TodayViewModel(with: $0) })
        self.datesDictionary = self.dateDictionary(from: self.forecast)
    
    }
    
    init(with error: WeatherError) {
        self.errorKind = error
        switch error {
        case .internet:
            self.errorViewImage = Assets.internetErrorImage.image
        case .location:
            self.errorViewImage = Assets.locationErrorImage.image
        case .unkown:
            self.errorViewImage = Assets.unkownErrorImage.image
        }
    }
    
    init() {}
    
    func dateDictionary(from forecast: [TodayViewModel]) ->  [String : [String]] {
        var dictionary = [String : [String]]()
        _ = self.forecast.map { (model) -> Void in
            let dateElements = model.date.split(separator: ",").compactMap({String($0)})
            if dateElements.count > 1 {
                let key = String(dateElements[0])
                let value = String(dateElements[1])
                dictionary.append(element: value, toValueOfKey: key)
            }
        }
        
        return dictionary
    }
    
    func sortedKeys(from dictionary: [String : [String]]) -> [String] {
        let keys = dictionary.keys
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd/MM/yy"
        
        let dateArray = keys.compactMap({dateFormatter.date(from: $0)!})
        let sortedDateArray = dateArray.sorted(by: { $0.compare($1) == .orderedAscending })
        
        return sortedDateArray.compactMap({ dateFormatter.string(from: $0) })
    }
    
    
}

extension Dictionary where Value: RangeReplaceableCollection {
    public mutating func append(element: Value.Iterator.Element, toValueOfKey key: Key) {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
    }
}

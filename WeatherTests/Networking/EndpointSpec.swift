//
//  EndpointSpec.swift
//  WeatherTests
//
//  Created by Matheus Vasconcelos on 28/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Moya

@testable import Weather

class EndpointSpec: QuickSpec {
    
    var sut: OpenWeatherMap!
    
    override func spec() {
        
        describe("the api endpoint") {

            context("when request is for current weather") {
                beforeEach {
                    self.sut = OpenWeatherMap.current((lat: "", lon: ""))
                }
                
                it("should return a valid baseURL") {
                    expect(self.sut.baseURL).to(equal(URL(string: "http://api.openweathermap.org/data/2.5")!))
                }
                
                it("should return a valid path") {
                    expect(self.sut.path).to(equal("/weather"))
                }
                
                it("should return get moya method") {
                    expect(self.sut.method).to(equal(.get))
                }
            }
            
            context("when request is for forecast weather") {
                beforeEach {
                    self.sut = OpenWeatherMap.forecast((lat: "", lon: ""))
                }
                
                it("should return a valid baseURL") {
                    expect(self.sut.baseURL).to(equal(URL(string: "http://api.openweathermap.org/data/2.5")!))
                }
                
                it("should return a valid path") {
                    expect(self.sut.path).to(equal("/forecast"))
                }
                
                it("should return get moya method") {
                    expect(self.sut.method).to(equal(.get))
                }
            }
        }
    }
}

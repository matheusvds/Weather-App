//
//  OpenWeatherMapSpec.swift
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

extension OpenWeatherMap {
    public var testSampleData: Data {
        switch self {
        case .current:
            let url = Bundle(for: OpenWeatherMapSpec.self)
                .url(forResource: "current", withExtension: "json")!
            return try! Data(contentsOf: url)
            
        case .forecast:
            let url = Bundle(for: OpenWeatherMapSpec.self)
                .url(forResource: "forecast", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
}

class OpenWeatherMapSpec: QuickSpec {
    
    var sut: MoyaProvider<OpenWeatherMap>!
    
    func customEndpointClosure(_ target: OpenWeatherMap) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func customErrorEndpointClosure(_ target: OpenWeatherMap) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(400, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    override func spec() {
        
        describe("the api provider") {
            
            context("when making a successful request") {
                var data: Any!
                var error: Error!
                
                beforeEach {
                    self.sut = MoyaProvider<OpenWeatherMap>(endpointClosure: self.customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
                }
                
                context("when requesting for current weather") {
                    beforeEach {
                        self.sut.request(.current((lat: "", lon: "")), completion: { (result) in
                            switch result {
                                
                            case .success(let response):
                                do {
                                    data = try response.map(Weather.self)
                                } catch (let err) {
                                    error = err
                                }
                            case .failure(let err):
                                error = err
                            }
                        })
                    }
                    
                    it("should have data of kind Weather") {
                        expect(data as? Weather).toEventuallyNot(beNil())
                    }
                    
                    it("should return nil error") {
                        expect(error).toEventually(beNil())
                    }
                }
                
                context("when requesting for the forecast weather") {
                    beforeEach {
                        self.sut.request(.forecast((lat: "", lon: "")), completion: { (result) in
                            switch result {
                                
                            case .success(let response):
                                do {
                                    data = try response.map(Forecast.self)
                                } catch (let err) {
                                    error = err
                                }
                            case .failure(let err):
                                error = err
                            }
                        })
                    }
                    
                    it("should have data of kind Weather") {
                        expect(data as? Forecast).toEventuallyNot(beNil())
                    }
                    
                    it("should return nil error") {
                        expect(error).toEventually(beNil())
                    }
                }
            }
            
            context("when making unsuccessful request") {
                var data: Any!
                var error: Error!
                
                beforeEach {
                    self.sut = MoyaProvider<OpenWeatherMap>(endpointClosure: self.customErrorEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
                }
                
                
                context("when requesting for current weather") {
                    beforeEach {
                        self.sut.request(.current((lat: "", lon: "")), completion: { (result) in
                            switch result {
                                
                            case .success(let response):
                                do {
                                    data = try response.map(Weather.self)
                                } catch (let err) {
                                    error = err
                                }
                            case .failure(let err):
                                error = err
                            }
                        })
                    }
                    
                    it("should return a nil response") {
                        expect(data).toEventually(beNil())
                    }
                    
                    it("should return a non nil error") {
                        expect(error).toEventuallyNot(beNil())
                    }
                }
                
                context("when requesting for the forecast weather") {
                    beforeEach {
                        self.sut.request(.forecast((lat: "", lon: "")), completion: { (result) in
                            switch result {
                                
                            case .success(let response):
                                do {
                                    data = try response.map(Forecast.self)
                                } catch (let err) {
                                    error = err
                                }
                            case .failure(let err):
                                error = err
                            }
                        })
                    }
                    
                    it("should return a nil response") {
                        expect(data).toEventually(beNil())
                    }
                    
                    it("should return a non nil error") {
                        expect(error).toEventuallyNot(beNil())
                    }
                }
            }
        }
        
        
    }
    
}

//
//  LocationManagerSpec.swift
//  WeatherTests
//
//  Created by Matheus Vasconcelos on 28/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import Weather

class LocationManagerStub: LocationManager {
    
    var setDelegateCalled = false
    var invalidateDelegateCalled = false
    
    override func setDelegate() {
        setDelegateCalled = true
    }
    
    override func invalidateDelegate() {
        invalidateDelegateCalled = true
    }
}


class LocationManagerSpec: QuickSpec {
    
    override func spec() {
        
        describe("the location manager") {
            
            context("when initialized") {
                var locationManager: LocationManagerStub!
                
                beforeEach {
                    locationManager = LocationManagerStub()
                }
                
                it("should set the function to set the delegate") {
                    expect(locationManager.setDelegateCalled).to(beTrue())
                }
            }
            
            context("when starting to request location") {
                var locationManager: LocationManagerStub!
                
                beforeEach {
                    locationManager = LocationManagerStub()
                    locationManager.setDelegateCalled = false
                    locationManager.startRequestingLocation()
                }
                
                it("should set the function to set the delegate") {
                    expect(locationManager.setDelegateCalled).to(beTrue())
                }
            }
            
            context("when stopping to request location") {
                var locationManager: LocationManagerStub!
                
                beforeEach {
                    locationManager = LocationManagerStub()
                    locationManager.stopRequestingLocation()
                }
                
                it("should invalidate the delegate") {
                    expect(locationManager.invalidateDelegateCalled).to(beTrue())
                }
            }
            
        }
        
        
        
    }
    
}

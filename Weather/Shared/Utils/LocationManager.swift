//
//  LocationManager.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 25/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func didStartLoadingLocation()
    func didEndLoadingLocation(with error:WeatherError)
    func didFound(city: String?, inCountry country: String?)
    func didFinishLocationRequesting(with location: Location)
}

extension LocationManagerDelegate {
    func didFound(city: String?, inCountry country: String?) {}
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationManagerDelegate?
    var bestEffortLocation: CLLocation?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.configureLocation()
    }
    
    fileprivate func configureLocation() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startRequestingLocation() {
        configureLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            self.delegate?.didStartLoadingLocation()
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
            return
        }
        self.delegate?.didEndLoadingLocation(with: .location)
    }
    
    
    
    func stopRequestingLocation() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    fileprivate func findCityFor(location: CLLocation, completion: @escaping () -> ()) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            self.getLocationFor(placemarks: placemarks, with: error)
            completion()
        })
    }
    
    fileprivate func check(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.startRequestingLocation()
            
        default:
            self.delegate?.didStartLoadingLocation()
            self.delegate?.didEndLoadingLocation(with: .location)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        check(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        let locationAge = newLocation.timestamp.timeIntervalSinceNow
        //Avoids cached locations
        if locationAge > 5.0 { return }
        
        //Avoids invalid measurements
        if newLocation.horizontalAccuracy < 0 { return }
        
        if(self.bestEffortLocation == nil) {
            self.bestEffortLocation = newLocation
        }
        
        guard let bestEffort = self.bestEffortLocation else { return }
        
        if(bestEffort.horizontalAccuracy >= newLocation.horizontalAccuracy) {
            self.bestEffortLocation = newLocation
            
            if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
                self.stopRequestingLocation()
                self.findCityFor(location: newLocation) {
                    let location: Location = (lat: newLocation.coordinate.latitude.asString,
                                              lon: newLocation.coordinate.longitude.asString)
                    self.delegate?.didFinishLocationRequesting(with: location)
                }
            }
        }
    }
    
    fileprivate func getLocationFor(placemarks: [CLPlacemark]?, with error: Error?) {
        guard let country = placemarks?.first?.country,
            let city = placemarks?.first?.locality, error == nil else {
                self.delegate?.didFound(city: nil, inCountry: nil)
                return
        }
        self.delegate?.didFound(city: city, inCountry: country)
    }
}

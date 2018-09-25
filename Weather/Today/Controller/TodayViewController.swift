//
//  TodayViewController.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

class TodayViewController: UIViewController {
    
    enum State {
        case loading
        case ready(Weather)
        case error(WeatherError)
    }

    // MARK: - View State
    private var state: State = .loading {
        didSet {
            switch state {
            case .ready(let response):
                let viewModel = TodayViewModel(with: response)
                self.todayView.stopLoading()
                self.todayView.configureView(with: viewModel)

            case .loading:
                self.todayView.startLoading()
                
            case .error(let error):
                let errorModel = TodayViewModel(with: error)
                self.todayView.configureView(withError: errorModel)
                self.todayView.stopLoading()
            }
        }
    }
    
    let viewModel = TodayViewModel()
    let provider: MoyaProvider<OpenWeatherMap>
    let todayView = TodayViewControllerScreen()
    var bestEffortLocation: CLLocation?
    var locationManager = CLLocationManager()

    init(provider: MoyaProvider<OpenWeatherMap> = MoyaProvider<OpenWeatherMap>()) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = todayView
        self.state = .loading
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupDelegates()
        configureLocation()
    }
    
    func setupDelegates() {
        self.todayView.errorView.delegate = self
        self.locationManager.delegate = self
        self.todayView.delegate = self
    }
    
    func requestData(with location: Location) {
        provider.request(.current(location)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Weather.self)
                    self.state = .ready(response)
                } catch {
                    self.state = .error(.unkown)
                }
            case .failure(let error):
                self.state = .error(WeatherError(error: error))
            }
        }
    }
}

//MARK: - ErrorView Delegate
extension TodayViewController: ErrorViewDelegate {
    func refreshButtonTapped() {
        setup()
        startRequestingLocation()
    }
    }
    
    func requestLocationSettings() {
        self.showSettingsAlert()
    }
}

//MARK: - CLLocationManager Delegate
extension TodayViewController: CLLocationManagerDelegate {
    func configureLocation() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startRequestingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopRequestingLocation() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    func findCityFor(location: CLLocation, completion: @escaping (String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {[weak self] (placemarks, error) in
            guard let self = self else { return }
            completion(self.viewModel.getLocationFor(placemarks: placemarks, with: error))
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.startRequestingLocation()
            
        default:
            self.state = .loading
            self.state = .error(.location)
            manager.stopUpdatingLocation()
        }
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
                self.findCityFor(location: newLocation) { (name) in
                    self.todayView.setLocation(name)
                    let location: Location = (lat: newLocation.coordinate.latitude.asString,
                                              lon: newLocation.coordinate.longitude.asString)
                    self.requestData(with: location)
                }
            }
        }
    }
}


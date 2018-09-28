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

    // MARK: - View State
    private var state: State<Weather> = .loading {
        didSet {
            switch state {
            case .ready(let response):
                let viewModel = TodayViewModel(with: response)
                self.todayView.configureView(with: viewModel)
                self.todayView.stopLoading()
                let firebaseData = UserData(with: response)
                FirebaseManager.saveUser(data: firebaseData.toDictionary())
    
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
    var locationManager = LocationManager()

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
        setupTitle()
        setupDelegates()
    }
    
    func setupTitle() {
        self.title = "Today"
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
    
    func snapshot(targetView: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetView.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: targetView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func setForecastViewController(title: String) {
       let navigation = self.tabBarController?.viewControllers?.first(where: { (element) -> Bool in
            let navigation = element as? UINavigationController
            let vc = navigation?.viewControllers.first as? TodayViewController
            return vc == nil
        })
        
        let forecastNav = navigation as? UINavigationController
        forecastNav?.visibleViewController?.navigationItem.title = title
    }
}

//MARK: - ErrorView, TodayView Delegates
extension TodayViewController: ErrorViewDelegate, TodayViewDelegate {
    func refreshButtonTapped() {
        self.locationManager.startRequestingLocation()
    }
    
    func shareButtonTapped() {
        let snapshot = self.snapshot(targetView: self.todayView)
        let activity = UIActivityViewController(activityItems: [snapshot], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
    
    func requestLocationSettings() {
        self.showSettingsAlert()
    }
}

//MARK: - CLLocationManager Delegate
extension TodayViewController: LocationManagerDelegate {
    func didStartLoadingLocation() {
        self.state = .loading
    }
    
    func didEndLoadingLocation(with error: WeatherError) {
        self.state = .error(error)
    }
    
    func didFound(city: String?, inCountry country: String?) {
        guard let city = city, let country = country else {
            self.todayView.setLocation("Couldn't find your location")
            return
        }
        self.setForecastViewController(title: city)
        self.todayView.setLocation("\(city), \(country)")
    }
    
    func didFinishLocationRequesting(with location: Location) {
        self.requestData(with: location)
    }
}


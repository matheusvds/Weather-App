//
//  ForecastViewController.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import Moya

class ForecastViewController: UIViewController {

    private var state: State<[Weather]> = .loading {
        didSet {
            switch state {
            case .ready(let forecast):
                let model = ForecastViewModel(data: forecast)
                self.forecastDatasource?.reloadData(with: model)
                self.forecastView.stopLoading()
            case .loading:
                self.forecastView.startLoading()
                
            case .error(let error):
                print(error)
                break
            }
        }
    }
   
    var provider: MoyaProvider<OpenWeatherMap>
    let forecastView = ForecastViewControllerScreen()
    var forecastDatasource: ForecastTableViewDatasource?
    
    init(provider: MoyaProvider<OpenWeatherMap> = MoyaProvider<OpenWeatherMap>()) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = forecastView
        self.state = .loading
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestData(with: (lat: "37.332", lon: "-122.406"))
    }
    
    func setup() {
        self.forecastDatasource = ForecastTableViewDatasource(forecast: ForecastViewModel(),
                                                              tableView: self.forecastView.tableView)
    }
    
    func requestData(with location: Location) {
        provider.request(.forecast(location)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Forecast.self)
                    self.state = .ready(response.list)
                } catch(let error) {
                    print(error)
                    self.state = .error(.unkown)
                }
            case .failure(let error):
                print(error)
                self.state = .error(WeatherError(error: error))
            }
        }
    }
}

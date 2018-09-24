//
//  TodayViewController.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import Moya

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
                self.todayView.configureView(with: viewModel)
                self.todayView.stopLoading()

            case .loading:
                self.todayView.startLoading()
                
            case .error(let error):
                let errorModel = TodayViewModel(with: .internet)
                self.todayView.configureView(withError: errorModel)
                self.todayView.stopLoading()
            }
        }
    }
    
    let provider: MoyaProvider<OpenWeatherMap>
    let todayView = TodayViewControllerScreen()
    
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
        requestData()
    }
    
    func setup() {
        self.todayView.errorView.delegate = self
    }
    
    func requestData() {
        provider.request(.current((lat: "", lon: ""))) { [weak self] result in
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

extension TodayViewController: ErrorViewDelegate {
    func refreshButtonTapped() {
        print("button tapped")
    }
}

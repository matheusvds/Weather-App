//
//  TodayViewScreen.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 23/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

class TodayViewControllerScreen: UIView {

    lazy var topDivider: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = Assets.topSeparatorImage.image
        return view
    }()
    
    lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Assets.todayCleaySkyTopIcon.image
        return imageView
    }()
    
    lazy var localizationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Assets.todayLocationIcon.image
        return imageView
    }()
    
    lazy var localizationLabel: UILabel = {
        let label = UILabel()
        label.text = "Prague, Czech Republic"
        label.textColor = .darkThemeColor
        label.setDefaultFont(size: 18.0, weight: .semibold)
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "22°C  |  Sunny"
        label.textColor = .blueThemeColor
        label.setDefaultFont(size: 24.0, weight: .regular)
        return label
    }()
    
    lazy var middleDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .grayThemeColor
        return view
    }()
    
    lazy var humidity: WeatherGroup = {
        let view = WeatherGroup()
        view.icon.image = Assets.todayHumidityIcon.image
        view.label.text = "-"
        return view
    }()
    
    lazy var precipitation: WeatherGroup = {
        let view = WeatherGroup()
        view.icon.image = Assets.todayPrecipitationIcon.image
        view.label.text = "-"
        return view
    }()
    
    lazy var pressure: WeatherGroup = {
        let view = WeatherGroup()
        view.icon.image = Assets.todayPressureIcon.image
        view.label.text = "-"
        return view
    }()
    
    lazy var windSpeed: WeatherGroup = {
        let view = WeatherGroup()
        view.icon.image = Assets.todayWindSpeedIcon.image
        view.label.text = "-"
        return view
    }()
    
    lazy var windDirection: WeatherGroup = {
        let view = WeatherGroup()
        view.icon.image = Assets.todayWindDirectionIcon.image
        view.label.text = "-"
        return view
    }()
    
    lazy var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .grayThemeColor
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let view = UIButton()
        view.setTitle("Share", for: .normal)
        view.setTitleColor(.orangeThemeColor, for: .normal)
        view.titleLabel?.setDefaultFont(size: 18.0, weight: .semibold)
        return view
    }()
    
    lazy var loading: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.animationImages = getLoadingImages()
       return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with model: TodayViewModel) {
        DispatchQueue.main.async {
            self.windDirection.label.text = model.windDirection
            self.windSpeed.label.text = model.windSpeed
            self.humidity.label.text = model.humidity
            self.pressure.label.text = model.pressure
            self.precipitation.label.text = model.rainVolume
            self.temperatureLabel.text = model.temperature
            self.weatherImage.tintColor = model.icon.tintColor
            self.weatherImage.image = model.icon.image
        }
    }

    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.bringSubviewToFront(self.loading)
            self.loading.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.sendSubviewToBack(self.loading)
            self.loading.stopAnimating()
        }
    }
    
    fileprivate func getLoadingImages() -> [UIImage] {
        var images = [UIImage]()
        for index in 0...29 {
            guard let image = UIImage(named: "loading\(index)") else {
                break
            }
            images.append(image)
        }
        return images
    }
}

extension TodayViewControllerScreen: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(topDivider)
        self.addSubview(weatherImage)
        self.addSubview(localizationIcon)
        self.addSubview(localizationLabel)
        self.addSubview(temperatureLabel)
        self.addSubview(middleDivider)
        self.addSubview(humidity)
        self.addSubview(precipitation)
        self.addSubview(pressure)
        self.addSubview(windSpeed)
        self.addSubview(windDirection)
        self.addSubview(bottomDivider)
        self.addSubview(shareButton)
        self.addSubview(loading)
    }
    
    func setupConstraints() {
        
        //Constants
        let topDividerHeight = 2
        let weatherImageSize = 100
        let topOffsetMultiplier = getMultiplierByScreenSize()
        let localizationLabelTopOffset = 15
        let temperatureLabelTopOffset = 10
        let localizationLabelHeight = 22
        let localizationIconSize = 12
        let localizationIconRightOffset = -20
        
        loading.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self)
        }
        
        topDivider.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(topDividerHeight)
        }
        
        weatherImage.snp.makeConstraints { (make) in
            make.height.width.equalTo(weatherImageSize)
            make.centerX.equalTo(self)
            make.top.equalTo(topDivider.snp.bottom).offset(25*topOffsetMultiplier)
        }
        
        localizationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherImage.snp.bottom).offset(localizationLabelTopOffset)
            make.height.equalTo(localizationLabelHeight)
            make.width.equalTo(localizationLabel.snp.width)
            make.centerX.equalTo(self)
                .offset((localizationIconSize + abs(localizationIconRightOffset))/2)
        }
        
        localizationIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(localizationLabel.snp.centerY)
            make.height.width.equalTo(localizationIconSize)
            make.centerX.equalTo(localizationLabel.snp.left).offset(localizationIconRightOffset)
        }
        
        temperatureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(localizationLabel.snp.bottom).offset(temperatureLabelTopOffset)
            make.height.equalTo(temperatureLabel.snp.height)
            make.width.equalTo(temperatureLabel.snp.width)
            make.centerX.equalTo(weatherImage.snp.centerX)
        }
        
        middleDivider.snp.makeConstraints { (make) in
            make.top.equalTo(temperatureLabel.snp.bottom)
                .offset(25*topOffsetMultiplier)
            make.width.equalTo(self).multipliedBy(0.35)
            make.centerX.equalTo(self)
            make.height.equalTo(1)
        }
        
        precipitation.snp.makeConstraints { (make) in
            make.top.equalTo(middleDivider.snp.bottom).offset(25)
            make.height.equalTo(precipitation.snp.height)
            make.width.equalTo(precipitation.snp.width)
            make.centerX.equalTo(middleDivider.snp.centerX)
        }
        
        humidity.snp.makeConstraints { (make) in
            make.top.equalTo(precipitation.snp.top)
            make.height.equalTo(humidity.snp.height)
            make.width.equalTo(humidity.snp.width)
            make.centerX.equalTo(precipitation.snp.left).offset(-120)
        }
        
        pressure.snp.makeConstraints { (make) in
            make.top.equalTo(precipitation.snp.top)
            make.height.equalTo(pressure.snp.height)
            make.width.equalTo(pressure.snp.width)
            make.centerX.equalTo(precipitation.snp.left).offset(120)
        }
        
        windSpeed.snp.makeConstraints { (make) in
            make.top.equalTo(precipitation.snp.bottom).offset(60)
            make.height.equalTo(windSpeed.snp.height)
            make.width.equalTo(windSpeed.snp.width)
            make.centerX.equalTo(precipitation.snp.left).offset(-60)
        }
        
        windDirection.snp.makeConstraints { (make) in
            make.top.equalTo(precipitation.snp.bottom).offset(60)
            make.height.equalTo(windDirection.snp.height)
            make.width.equalTo(windDirection.snp.width)
            make.centerX.equalTo(precipitation.snp.left).offset(60)
        }
        
        bottomDivider.snp.makeConstraints { (make) in
            make.top.equalTo(windDirection.snp.bottom).offset(80)
            make.width.equalTo(self).multipliedBy(0.35)
            make.centerX.equalTo(self)
            make.height.equalTo(1)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.top.equalTo(bottomDivider.snp.bottom).offset(20)
            make.width.equalTo(shareButton.snp.width)
            make.height.equalTo(shareButton.snp.height)
            make.centerX.equalTo(self)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
    
    fileprivate func getMultiplierByScreenSize() -> CGFloat {
        let size = UIScreen.main.bounds.height
        switch size {
        case size where size <= 568.0:
            return 1.0
        case size where size > 568.0 && size <= 667.0:
            return 2.0
        case size where size > 667.0 && size <= 736.0:
            return 2.0
        default:
            return 2.0
        }
    }
    
}

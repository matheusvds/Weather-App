//
//  ForecastCellView.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 26/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    lazy var icon: UIImageView = {
        let view = UIImageView()
        view.tintColor = .yellowThemeColor
        view.image = Assets.todayCleaySkyTopIcon.image
        return view
    }()
    
    lazy var time: UILabel = {
        let label = UILabel()
        label.setDefaultFont(size: 18.0, weight: .semibold)
        label.textColor = .darkThemeColor
        return label
    }()
    
    lazy var weather: UILabel = {
        let label = UILabel()
        label.setDefaultFont(size: 15.0, weight: .regular)
        label.textColor = .darkThemeColor
        return label
    }()
    
    lazy var temperature: UILabel = {
        var label = UILabel()
        label.setDefaultFont(size: 50.0, weight: .light)
        label.textColor = .blueThemeColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TodayViewModel) {
        self.icon.image = viewModel.icon.image
        self.weather.text = viewModel.weatherDescription
        self.temperature.text = String(viewModel.temperature.dropLast())
    }
    
    func configure(timeFrom data: String) {
        self.time.text = data
    }
    
}

extension ForecastCell: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(self.icon)
        self.addSubview(self.time)
        self.addSubview(self.weather)
        self.addSubview(self.temperature)
    }
    
    func setupConstraints() {
        self.icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    
        self.time.snp.makeConstraints { (make) in
            make.left.equalTo(self.icon.snp.right).offset(20)
            make.height.width.equalTo(self.time)
            make.centerY.equalTo(self.icon.snp.centerY).offset(-10)
        }
        
        self.weather.snp.makeConstraints { (make) in
            make.left.equalTo(self.time.snp.left)
            make.width.height.equalTo(self.weather)
            make.centerY.equalTo(self.icon.snp.centerY).offset(10)
            
        }
        
        self.temperature.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.height.width.equalTo(self.temperature)
            make.centerY.equalToSuperview()
        }
    }
}


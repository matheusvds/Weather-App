//
//  WeatherGroup.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 23/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

class WeatherGroup: UIView {
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.setDefaultFont(size: 15.0, weight: .semibold)
        label.textColor = UIColor.darkThemeColor
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherGroup: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(icon)
        self.addSubview(label)
    }
    
    func setupConstraints() {
        
        let iconSize = 30
        let labelTopOffset = 5
        
        self.icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(iconSize)
            make.top.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        self.label.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(labelTopOffset)
            make.height.equalTo(label.snp.height)
            make.width.equalTo(label.snp.width)
            make.centerX.equalTo(self)
        }
    }
}

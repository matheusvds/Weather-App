//
//  LocationErrorView.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 24/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

protocol ErrorViewDelegate: class {
    func refreshButtonTapped()
    func requestLocationSettings()
}

extension ErrorViewDelegate {
    func requestLocation() {}
}

class ErrorView: UIView {
    
    weak var delegate: ErrorViewDelegate?
    
    lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    var errorKind: WeatherError {
        didSet {
            let title = errorKind == .location ? "Request location" : "Refresh"
            button.setTitle(title, for: .normal)
        }
    }
    
    init(frame: CGRect = .zero, errorKind: WeatherError = .unkown) {
        self.errorKind = errorKind
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        self.button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.setDefaultFont(size: 18.0, weight: .semibold)
        button.setTitleColor(.orangeThemeColor, for: .normal)
        button.setTitleColor(.blueThemeColor, for: .highlighted)
    }
    
    @objc
    func buttonAction() {
        switch self.errorKind {
        case .location:
            self.delegate?.requestLocationSettings()
        default:
            self.delegate?.refreshButtonTapped()
        }
    }
}

extension ErrorView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(background)
        self.addSubview(button)
    }
    
    func setupConstraints() {
        background.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(button)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.87)
        }
    }
    
    func setupAdditionalConfiguration() {
        configureButton()
        self.backgroundColor = .white
    }
}

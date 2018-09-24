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
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.setDefaultFont(size: 18.0, weight: .semibold)
        button.setTitleColor(.orangeThemeColor, for: .normal)
        button.setTitleColor(.blueThemeColor, for: UIControl.State.highlighted)
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func buttonAction() {
        self.delegate?.refreshButtonTapped()
    }
}

extension ErrorView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(background)
        self.addSubview(button)
    }
    
    func setupConstraints() {
        background.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(button)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.87)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        self.bringSubviewToFront(button)
        self.button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

//
//  LocationErrorView.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 24/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

class ErrorView: UIView {
    
    lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.LocationErrorImage.image
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Press here"
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.centerY.equalToSuperview().multipliedBy(1.3)
        }
    }
}

//
//  ForecastHeaderView.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 27/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

class ForecastHeaderView: UITableViewHeaderFooterView {
    
    lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .grayThemeColor
        return view
    }()
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.setDefaultFont(size: 14.0, weight: .bold)
        return label
    }()
    
    lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .grayThemeColor
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastHeaderView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(self.topSeparator)
        self.addSubview(self.label)
        self.addSubview(self.bottomSeparator)
    }
    
    func setupConstraints() {
        
        self.topSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        self.label.snp.makeConstraints { (make) in
            make.width.equalTo(self.label)
            make.height.equalTo(15)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        self.bottomSeparator.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

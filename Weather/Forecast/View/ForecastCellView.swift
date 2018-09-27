//
//  ForecastCellView.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 26/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var time: UILabel = {
        let label = UILabel()
        label.setDefaultFont(size: 18.0, weight: .semibold)
        return label
    }()
    
    lazy var weather: UILabel = {
        let label = UILabel()
        label.setDefaultFont(size: 15.0, weight: .regular)
        return label
    }()
    
    lazy var temperature: UILabel = {
        var label = UILabel()
        label.setDefaultFont(size: 50.0, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieCell: ViewCode {
    
    func buildViewHierarchy() {

    }
    
    func setupConstraints() {

    }
    
    func setupAdditionalConfiguration() {
        
    }
}


//
//  ForecastView.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 25/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

class ForecastViewControllerScreen: UIView {
    
    lazy var topDivider: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Assets.topSeparatorImage.image
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .plain)
        return tableView
    }()
    
    lazy var loading: Loading = {
        let view = Loading()
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            self.loading.stopAnimating()
            self.sendSubviewToBack(self.loading)
        }
    }
}

extension ForecastViewControllerScreen: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(self.tableView)
        self.addSubview(self.loading)
        self.addSubview(self.topDivider)

    }
    
    func setupConstraints() {
        
        self.loading.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self)
        }
        
        self.topDivider.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(topDivider.snp.height)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.tableView.rowHeight = 90
        self.tableView.separatorInset.left = 100
    }
}

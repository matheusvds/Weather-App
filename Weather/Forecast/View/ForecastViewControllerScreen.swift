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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .plain)
        return tableView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastViewControllerScreen: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
}

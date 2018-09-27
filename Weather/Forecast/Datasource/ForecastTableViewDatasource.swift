//
//  ForecastTableViewDatasource.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 25/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class ForecastTableViewDatasource: NSObject {
    
    var data: [Weather]
    var tableView: UITableView
    
    init(forecast: [Weather],
         tableView: UITableView) {
        self.data = forecast
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }
    
    func reloadData(with forecast: [Weather]) {
        self.data = forecast
        self.tableView.reloadData()
    }
}

extension ForecastTableViewDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

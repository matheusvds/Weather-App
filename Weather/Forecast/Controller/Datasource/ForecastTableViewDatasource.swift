//
//  ForecastTableViewDatasource.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 25/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class ForecastTableViewDatasource: NSObject {
    
    var data: ForecastViewModel
    var tableView: UITableView
    
    init(forecast: ForecastViewModel,
         tableView: UITableView) {
        self.data = forecast
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(ForecastCell.self, forCellReuseIdentifier: "forecastCell")
        self.tableView.register(ForecastHeaderView.self, forHeaderFooterViewReuseIdentifier: "forecastHeaderView")
    }
    
    func reloadData(with forecast: ForecastViewModel) {
        self.data = forecast
        self.tableView.reloadData()
    }
}

extension ForecastTableViewDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dates = self.data.datesDictionary
        let sortedWeekDaysKeys = self.data.sortedKeys
        
        return dates[sortedWeekDaysKeys[section]]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.sortedKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? ForecastCell else {
            return UITableViewCell()
        }
        let dates = self.data.datesDictionary
        let sortedWeekDaysKeys = self.data.sortedKeys

        guard let dayTimes = dates[sortedWeekDaysKeys[indexPath.section]] else { return UITableViewCell() }
        
        cell.configure(with: data.forecast[indexPath.row])
        cell.configure(timeFrom: dayTimes[indexPath.row])
        return cell
    }
}


extension ForecastTableViewDatasource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "forecastHeaderView") as? ForecastHeaderView else {
            return UITableViewHeaderFooterView()
        }
        header.label.text = self.data.weekDays[section].uppercased()
        return header
    }
}

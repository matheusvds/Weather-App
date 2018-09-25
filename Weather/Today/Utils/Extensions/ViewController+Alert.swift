//
//  ViewController+Alert.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 24/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSettingsAlert() {
        let alertController = UIAlertController(
            title: "Settings",
            message: "Go to settings to change you location access?",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: nil)
        
        let settingsAction = UIAlertAction(title: "Settings",
                                           style: .default) { (_) in
                                            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

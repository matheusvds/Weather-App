//
//  AppDelegate.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        loginUser()
        configureApp()
        return true
    }
    
    func loginUser() {
        Auth.auth().signInAnonymously { (userAuth, error) in
            guard let _ = userAuth, error == nil else {
                print("Could not login user")
                return
            }
            print("User logged in")
        }
    }
    
    func configureApp() {
        let todayViewController = TodayViewController()
        let todayNavigationController = NavigationController(rootViewController: todayViewController)
        
        let forecastViewController = ForecastViewController()
        let forecastNavigationController = NavigationController(rootViewController: forecastViewController)
        
        let tabBarController = TabBarController(with: [todayNavigationController, forecastNavigationController])
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        self.window = window
        
        window.makeKeyAndVisible()
    }

}


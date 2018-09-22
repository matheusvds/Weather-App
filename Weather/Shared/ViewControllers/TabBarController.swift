//
//  TabBarController.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 22/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(with viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItems(in: viewControllers)
        setupAppearance()
        self.viewControllers = viewControllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBarItems(in viewControllers: [UIViewController]) {
        
        for (index, controller) in viewControllers.enumerated() {
            switch index {
            case 0:
                controller.tabBarItem = UITabBarItem(title: "Today",
                                                     image: Assets.todayTabbarIcon.image,
                                                     tag: index)
            case 1:
                controller.tabBarItem = UITabBarItem(title: "Forecast",
                                                     image: Assets.forecastTabbarIcon.image,
                                                     tag: index)
            default:
                break
            }
        }
    }
    
    private func setupAppearance() {
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = .tabBarSelectedColor
        self.tabBar.unselectedItemTintColor = .tabBarUnselectedColor
    }
}

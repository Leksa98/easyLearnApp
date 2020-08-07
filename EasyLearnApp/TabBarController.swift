//
//  TabBarController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Constants
    
    enum Locals {
        static let tabBarTextColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let tabBarBackgroundColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        static let tabBarBorderWidth: CGFloat = 0.2
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = Locals.tabBarTextColor
        tabBar.barTintColor = Locals.tabBarBackgroundColor
        tabBar.layer.borderWidth = Locals.tabBarBorderWidth
        
        let wordSetsViewController = UINavigationController()
        wordSetsViewController.pushViewController(AllWordSetsConfigurator.assembly(), animated: false)
        wordSetsViewController.tabBarItem = UITabBarItem(title: "Sets", image: UIImage(named: "file"), tag: 0)
        
        let newWordSetViewController = UINavigationController()
        newWordSetViewController.pushViewController(NewWordSetViewController(), animated: false)
        newWordSetViewController.tabBarItem = UITabBarItem(title: "Add set", image: UIImage(named: "plus-sign"), tag: 1)
        
        let wordOfDayViewController = UINavigationController()
        wordOfDayViewController.view.backgroundColor = .orange
        wordOfDayViewController.tabBarItem = UITabBarItem(title: "Word of the day", image: UIImage(named: "calendar"), tag: 2)
        
        let settingsViewController = UINavigationController()
        settingsViewController.pushViewController(SettingsViewController(), animated: false)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "gear"), tag: 3)
        
        let tabBarList = [wordSetsViewController, newWordSetViewController, wordOfDayViewController, settingsViewController]
        viewControllers = tabBarList
    }
}

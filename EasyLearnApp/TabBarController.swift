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
        
        let wordSetsViewController = AllWordSetTableViewController()
        let wordSetsNavigationController = UINavigationController(rootViewController: wordSetsViewController)
        AllWordSetsConfigurator.assembly(viewController: wordSetsViewController)
        wordSetsNavigationController.tabBarItem = UITabBarItem(title: "Sets", image: UIImage(named: "file"), tag: 0)
        
        let newWordSetViewController = NewWordSetViewController()
        let newWordSetNavigationController = UINavigationController(rootViewController: newWordSetViewController)
        NewWordSetConfiguration.assembly(viewController: newWordSetViewController)
        newWordSetNavigationController.tabBarItem = UITabBarItem(title: "Add set", image: UIImage(named: "plus-sign"), tag: 1)
        
        let wordOfDayViewController = UINavigationController()
        wordOfDayViewController.view.backgroundColor = .orange
        wordOfDayViewController.tabBarItem = UITabBarItem(title: "Word of the day", image: UIImage(named: "calendar"), tag: 2)
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        SettingsConfigurator.assembly(viewController: settingsViewController)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "gear"), tag: 3)
        
        let tabBarList = [wordSetsNavigationController, newWordSetNavigationController, wordOfDayViewController, settingsNavigationController]
        viewControllers = tabBarList
    }
}

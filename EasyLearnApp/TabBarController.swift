//
//  TabBarController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        if let font = UIFont.sfProTextHeavy(ofSize: 10) {
            let attributes = [NSAttributedString.Key.font: font]
            appearance.setTitleTextAttributes(attributes, for: .normal)
        }
        
        tabBar.tintColor = UIColor.blueSapphire
        tabBar.barTintColor = UIColor.white
        
        let wordSetsViewController = AllWordSetTableViewController()
        let wordSetsNavigationController = UINavigationController(rootViewController: wordSetsViewController)
        AllWordSetTableConfigurator.assembly(viewController: wordSetsViewController)
        wordSetsNavigationController.tabBarItem = UITabBarItem(title: "Sets", image: UIImage(named: "Home"), tag: 0)
        
        let newWordSetViewController = NewWordSetViewController()
        let newWordSetNavigationController = UINavigationController(rootViewController: newWordSetViewController)
        NewWordSetConfiguration.assembly(viewController: newWordSetViewController)
        newWordSetNavigationController.tabBarItem = UITabBarItem(title: "New set", image: UIImage(named: "Plus"), tag: 1)
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        SettingsConfigurator.assembly(viewController: settingsViewController)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Settings"), tag: 2)
        
        let tabBarList = [wordSetsNavigationController, newWordSetNavigationController, settingsNavigationController]
        viewControllers = tabBarList
    }
}

//
//  TabBarController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        tabBar.layer.borderWidth = 0.2
        let firstViewController = UINavigationController()
        firstViewController.pushViewController(WordSetTableViewController(), animated: false)
        firstViewController.tabBarItem = UITabBarItem(title: "Sets", image: UIImage(named: "file"), tag: 0)
        
        let secondViewController = UINavigationController()
        secondViewController.pushViewController(AddSetViewController(), animated: false)
        secondViewController.tabBarItem = UITabBarItem(title: "Add set", image: UIImage(named: "plus-sign"), tag: 1)
        
        let thirdViewController = UINavigationController()
        thirdViewController.view.backgroundColor = .orange
        thirdViewController.tabBarItem = UITabBarItem(title: "Word of the day", image: UIImage(named: "calendar"), tag: 2)
        
        let forthViewController = UINavigationController()
        forthViewController.view.backgroundColor = .green
        forthViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "gear"), tag: 2)
        let tabBarList = [firstViewController, secondViewController, thirdViewController, forthViewController]
        viewControllers = tabBarList
        
    }
}

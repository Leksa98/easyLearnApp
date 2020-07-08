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
        
        tabBar.barTintColor = .white
        let firstViewController = UINavigationController()
        firstViewController.pushViewController(WordSetTableViewController(), animated: false)
        firstViewController.tabBarItem = UITabBarItem(title: "Sets", image: UIImage(named: "file"), tag: 0)
        
        let secondViewController = UINavigationController()
        secondViewController.pushViewController(ViewController(), animated: false)
        secondViewController.view.backgroundColor = .cyan
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

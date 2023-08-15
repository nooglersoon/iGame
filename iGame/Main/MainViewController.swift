//
//  ViewController.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = setupTabBarItem()
        
        // Add view controllers to the tab bar controller
        self.viewControllers = viewControllers
        self.tabBar.backgroundColor = .white
    }
    
    func setupTabBarItem() -> [UIViewController] {
        
        // Create your view controllers here
        let viewController1 = UINavigationController(rootViewController: HomeViewController())
        viewController1.navigationBar.prefersLargeTitles = true
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .green
        
        // Create tab bar items
        let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        viewController1.tabBarItem = tabBarItem1
        
        let tabBarItem2 = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        viewController2.tabBarItem = tabBarItem2
        
        return [viewController1, viewController2]
        
    }
    
}


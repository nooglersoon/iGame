//
//  ViewController.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import UIKit

class MainViewController: UITabBarController {
    
    let networkService: NetworkService = NetworkService.shared
    
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

        // Create your view controllers here
        let viewController2 = UINavigationController(rootViewController: FavoritesViewController())
        viewController2.navigationBar.prefersLargeTitles = true
        
        // Create tab bar items
        let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        tabBarItem1.accessibilityIdentifier = "homeTabItem"
        viewController1.tabBarItem = tabBarItem1
        
        let tabBarItem2 = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        tabBarItem2.accessibilityIdentifier = "favoriteTabItem"
        viewController2.tabBarItem = tabBarItem2
        
        return [viewController1, viewController2]
        
    }
    
}


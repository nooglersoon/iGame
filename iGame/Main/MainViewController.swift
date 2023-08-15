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
        let viewController1 = UINavigationController(rootViewController: HomeViewController(service: networkService))
        viewController1.navigationBar.prefersLargeTitles = true
        
        // Replace this with your actual game data
        let sampleGame = GameModel(
            title: "Sample Game Title",
            releaseDate: "January 1, 2023",
            rating: 4.5,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit..."
        )

        let gameDetailViewController = GameDetailViewController()
        gameDetailViewController.game = sampleGame

        // Present the game detail view controller as needed
        
        let viewController2 = UINavigationController(rootViewController: gameDetailViewController)
        
        // Create tab bar items
        let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        viewController1.tabBarItem = tabBarItem1
        
        let tabBarItem2 = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        viewController2.tabBarItem = tabBarItem2
        
        return [viewController1, viewController2]
        
    }
    
}


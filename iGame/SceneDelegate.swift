//
//  SceneDelegate.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 2.
        let window = UIWindow(windowScene: windowScene)
        
        // Set Categories as Root ViewController
        let tabBarController = createTabBarController()
        window.rootViewController = tabBarController
        
        // 4.
        window.makeKeyAndVisible()
        
        // 5.
        self.window = window
        
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
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
        
        // Add view controllers to the tab bar controller
        tabBarController.viewControllers = [viewController1, viewController2]
        tabBarController.tabBar.backgroundColor = .white
        
        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}


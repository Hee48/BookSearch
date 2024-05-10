//
//  SceneDelegate.swift
//  BookSearch
//
//  Created by Hee  on 5/3/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
   
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let tabBarVC = UITabBarController()
        
        let searchVC = SearchViewController()
        searchVC.view.backgroundColor = .white
        searchVC.tabBarItem = UITabBarItem(title: nil, image: .search, tag: 0)
        
        let bookListVC = BookListViewController()
        bookListVC.view.backgroundColor = .white
        bookListVC.tabBarItem = UITabBarItem(title: nil, image: .bookmark, tag: 1)
        
        tabBarVC.viewControllers = [searchVC, bookListVC]
        //처음으로 보여주고싶은 화면을 넣는것
        self.window?.rootViewController = tabBarVC
        tabBarVC.tabBar.backgroundColor = .white
        //설정한뷰를 윈도우에 보여주는 메서드
        window?.makeKeyAndVisible()
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


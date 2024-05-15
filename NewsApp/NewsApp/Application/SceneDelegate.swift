//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let factory = DefaultNewsCollectionFactory()
        let configured = factory.configured(NewsCollectionViewController())
        let navigationController = UINavigationController(rootViewController: configured)
        
//        let navigationController = UINavigationController(rootViewController: ArticleDetailsViewController())
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Ильнур Закиров on 22.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
    
    var factory: FactoryProtocol?
    
    
    func start() -> UITabBarController {
        let tabVC = UITabBarController()
        tabVC.tabBar.backgroundColor = .white
         
        let navi1 = UINavigationController()
        let feedCoordinator = FeedCoordinator(navi: navi1, factory: factory!)
        feedCoordinator.makeSelf()
        navi1.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let navi2 = UINavigationController()
        let loginCoordinator = Coordinator(navi: navi2 , factory: factory!)
        loginCoordinator.openSelf()
        navi2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        tabVC.viewControllers = [navi1, navi2]
        return tabVC
    }
}

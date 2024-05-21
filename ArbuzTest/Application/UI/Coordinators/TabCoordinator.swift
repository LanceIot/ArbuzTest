//
//  TabCoordinator.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import UIKit

final class TabCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> ())?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    private let tabBarController: UITabBarController

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
        self.tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.backgroundColor = .lightGray
    }
    
    override func start() {
        
        let firstNavigationController = UINavigationController()
        let secondNavigationController = UINavigationController()
        
        let mainCoordinator = MainCoordinator(router: RouterImp(rootController: firstNavigationController), screenFactory: screenFactory)
        self.addDependency(mainCoordinator)
        mainCoordinator.start()
        
        firstNavigationController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), selectedImage: nil)
        secondNavigationController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), selectedImage: nil)
        
        
        let cartCoordinator = CartCoordinator(router: RouterImp(rootController: secondNavigationController), screenFactory: screenFactory)
        self.addDependency(cartCoordinator)
        cartCoordinator.start()
        
        tabBarController.viewControllers = [firstNavigationController, secondNavigationController]
        
        router.setRootModule(tabBarController, hideBar: true)
    }
}

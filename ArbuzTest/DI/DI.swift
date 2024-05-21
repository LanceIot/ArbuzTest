//
//  DI.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import UIKit
import SwiftUI

final class Di {
    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    
    
    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactory {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
}

protocol ScreenFactory {
    func makeMainScreen(viewModel: MainViewModel) -> UIHostingController<MainView>
    func makeCartScreen(viewModel: CartViewModel) -> UIHostingController<CartView>
    func makeDetailScreen(viewModel: DetailViewModel) -> UIHostingController<DetailView>
}

final class ScreenFactoryImpl: ScreenFactory {
    
    func makeMainScreen(viewModel: MainViewModel) -> UIHostingController<MainView> {
        let mainView = MainView(viewModel: viewModel)
        return UIHostingController(rootView: mainView)
    }
    
    func makeCartScreen(viewModel: CartViewModel) -> UIHostingController<CartView> {
        let cartView = CartView(viewModel: viewModel)
        return UIHostingController(rootView: cartView)
    }
    
    func makeDetailScreen(viewModel: DetailViewModel) -> UIHostingController<DetailView> {
        let detailView = DetailView(viewModel: viewModel)
        return UIHostingController(rootView: detailView)
    }
}

protocol CoordinatorFactory {
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
    
    func makeMainCoordinator(router: Router) -> TabCoordinator
    
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    
    private let screenFactory: ScreenFactory
    
    init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeMainCoordinator(router: Router) -> TabCoordinator {
        return TabCoordinator(router: router, screenFactory: screenFactory)
    }
}

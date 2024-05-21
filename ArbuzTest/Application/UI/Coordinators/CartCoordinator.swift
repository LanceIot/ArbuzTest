//
//  CartCoordinator.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import UIKit
import SwiftUI

final class CartCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> ())?
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showCart()
    }
    
    private func showCart() {
       let viewModel = CartViewModel()
        
        let cartScreen = screenFactory.makeCartScreen(viewModel: viewModel)
        router.setRootModule(cartScreen, hideBar: true)
    }
}

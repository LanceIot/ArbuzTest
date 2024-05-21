//
//  MainCoordinator.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import UIKit
import SwiftUI

final class MainCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> ())?
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showMain()
    }
    
    private func showMain() {
        let viewModel = MainViewModel()
        
        let mainScreen = screenFactory.makeMainScreen(viewModel: viewModel)
        router.setRootModule(mainScreen, hideBar: true)
    }
}

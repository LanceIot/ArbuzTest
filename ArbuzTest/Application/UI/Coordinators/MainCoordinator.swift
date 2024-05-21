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
        viewModel.onSelectProduct = { [weak self] id in
            DispatchQueue.main.async {
                self?.openDetails(id: id)
            }
        }
        let mainScreen = screenFactory.makeMainScreen(viewModel: viewModel)
        router.setRootModule(mainScreen, hideBar: true)
    }
    
    private func openDetails(id: UUID) {
        let viewModel = DetailViewModel(id: id)
        let detailView = screenFactory.makeDetailScreen(viewModel: viewModel)
        DispatchQueue.main.async { [weak self] in
            self?.router.present(detailView, animated: true)
        }
    }
}

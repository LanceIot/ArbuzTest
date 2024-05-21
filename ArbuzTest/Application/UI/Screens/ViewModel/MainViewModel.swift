//
//  MainViewModel.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
        
    var onSelectProduct: ((UUID) -> ())?
        
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadProducts() {
        self.isLoading = true
        Task {
            do {
                let loadedProducts = try await APICaller.shared.loadProducts()
                DispatchQueue.main.async {
                    self.products = loadedProducts
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func openProduct(with id: UUID) {
        onSelectProduct?(id)
    }
}

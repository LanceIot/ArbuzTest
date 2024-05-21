//
//  CartViewModel.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadProducts() {
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
}

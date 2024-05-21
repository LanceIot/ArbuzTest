//
//  DetailView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    @State var productID: UUID
    @Published var product: Product
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(id: UUID) {
        self.productID = id
        product = Product(id: UUID(), name: "", price: 0, isFavorite: false, isKilo: false, count: 0, minCount: 1, maxCount: 10, imageUrl: "", description: "")
    }
    
    func loadProduct() {
        self.isLoading = true
        Task {
            do {
                let loadedProduct = try await APICaller.shared.getProduct(by: productID)
                DispatchQueue.main.async {
                    if let loadedProduct {
                        self.product = loadedProduct
                        self.isLoading = false
                    }
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

//
//  DetailView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    var dismissed: (() -> ())?
    
    @State var productID: UUID
    @Published var product: Product
    
    init(id: UUID) {
        self.productID = id
        product = Product(id: UUID(), name: "", price: 0, isFavorite: false, isKilo: false, count: 0, minCount: 1, maxCount: 10, imageUrl: "", description: "")
    }
    
    func loadProduct(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let loadedProduct = try await APICaller.shared.getProduct(by: productID)
                DispatchQueue.main.async {
                    if let loadedProduct {
                        self.product = loadedProduct
                        completion(true)
                    }
                }
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func dismissView() {
        dismissed?()
    }
}

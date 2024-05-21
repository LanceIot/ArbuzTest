//
//  CartViewModel.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI
import CoreData

class CartViewModel: ObservableObject {
        
    @Published var cartProducts: [Product] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func getCartProducts(completion: @escaping () -> ()) {
        CartManager.shared.getAllProducts(completion: { result in
            switch result {
            case .success(let products):
                self.cartProducts = products
                completion()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                completion()
            }
        })
    }
}

//
//  MainViewModel.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(id: UUID(), name: "Banan", price: 999, isFavorite: false, isKilo: true, minCount: 1, maxCount: 10, imageUrl: "png", description: "Banana sweet"),
        Product(id: UUID(), name: "Nescafe", price: 450, isFavorite: false, isKilo: false, minCount: 1, maxCount: 20, imageUrl: "png", description: "Nescafe gold"),
        Product(id: UUID(), name: "Pepsi 0.5l", price: 390, isFavorite: false, isKilo: false, minCount: 1, maxCount: 15, imageUrl: "png", description: "Pepsi Cola"),
        Product(id: UUID(), name: "Chicken wing", price: 2899, isFavorite: false, isKilo: true, minCount: 1, maxCount: 12, imageUrl: "png", description: "Chiken wing"),
        Product(id: UUID(), name: "Egg 20pc", price: 1560, isFavorite: false, isKilo: false, minCount: 1, maxCount: 7, imageUrl: "png", description: "Egg C1 20 piece")
    ]
}

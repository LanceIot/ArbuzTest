//
//  APICaller.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    func loadProducts() async throws -> [Product] {
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        let products = try JSONDecoder().decode([Product].self, from: data)
        return products
    }
    
    func getProduct(by id: UUID) async throws -> Product? {
        let products = try await loadProducts()
        return products.first { $0.id == id }
    }
}

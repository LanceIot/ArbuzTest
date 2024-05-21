//
//  Product.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: UUID
    var name: String
    var price: Int
    var isFavorite: Bool
    var isKilo: Bool
    var minCount: Int
    var maxCount: Int
    var imageUrl: String
    var description: String
}

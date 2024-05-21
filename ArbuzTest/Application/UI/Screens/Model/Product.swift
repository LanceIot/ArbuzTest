//
//  Product.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import Foundation

struct Product: Identifiable, Codable {
    var id = UUID()
    var name: String
    var price: Int
    var isFavorite: Bool
    var isKilo: Bool
    var count: Int
    var minCount: Int
    var maxCount: Int
    var imageUrl: String
    var description: String
}   

extension Product {
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "name": name,
            "price": price,
            "isFavorite": isFavorite,
            "isKilo": isKilo,
            "count": count,
            "minCount": minCount,
            "maxCount": maxCount,
            "imageUrl": imageUrl,
            "description": description
        ]
    }
}

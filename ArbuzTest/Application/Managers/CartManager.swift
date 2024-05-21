//
//  CartManager.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import FirebaseFirestore

class CartManager {
    static let shared = CartManager()
    private let db = Firestore.firestore()
    private let cartCollection = "cart"
    
    private init() {}
    
    func addProductToCart(product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        let cartRef = db.collection(cartCollection)
        do {
            try cartRef.document(product.id.uuidString).setData(from: product) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateProductCount(product: Product, newCount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let cartRef = db.collection(cartCollection)
        let documentRef = cartRef.document(product.id.uuidString)
        
        documentRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                documentRef.updateData(["count": newCount]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                var newProduct = product
                newProduct.count = newCount
                self.addProductToCart(product: newProduct, completion: completion)
            }
        }
    }
    
    func removeProductFromCart(productID: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        let cartRef = db.collection(cartCollection)
        cartRef.document(productID.uuidString).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let cartRef = db.collection(cartCollection)
        cartRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                let products = documents.compactMap { try? $0.data(as: Product.self) }
                completion(.success(products))
            }
        }
    }
    
    func getProductCount(productID: UUID, completion: @escaping (Result<Int, Error>) -> Void) {
        let cartRef = db.collection(cartCollection)
        let documentRef = cartRef.document(productID.uuidString)
        
        documentRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let count = document.get("count") as? Int {
                    completion(.success(count))
                } else {
                    completion(.failure(NSError(domain: "Product count not found", code: 404, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "Product not found", code: 404, userInfo: nil)))
            }
        }
    }
    
    func checkIsFavorite(productID: UUID, completion: @escaping (Result<Bool, Error>) -> Void) {
        let cartRef = db.collection(cartCollection)
        let documentRef = cartRef.document(productID.uuidString)
        
        documentRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let isFavorite = document.get("isFavorite") as? Bool {
                    completion(.success(isFavorite))
                } else {
                    completion(.failure(NSError(domain: "Cant check isFavorite", code: 404, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "Product not found", code: 404, userInfo: nil)))
            }
        }
    }
    
    func updateProductIsFavorite(productID: UUID, isFavorite: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
            let cartRef = db.collection(cartCollection)
            let documentRef = cartRef.document(productID.uuidString)
            
            documentRef.getDocument { document, error in
                if let error = error {
                    completion(.failure(error))
                } else if let document = document, document.exists {
                    documentRef.updateData(["isFavorite": isFavorite]) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                } else {
                    completion(.failure(NSError(domain: "Product not found", code: 404, userInfo: nil)))
                }
            }
        }
    
}


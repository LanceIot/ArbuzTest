//
//  ProductCardView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

struct ProductCardView: View {
    
    @State var product: Product
    @State private var count: Int = 0
    
    private let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            VStack {
                Image("png")
                    .resizable()
                    .scaledToFit()
            }
            .frame(height: screenSize.height * 0.16)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
            .overlay(
                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                    .onTapGesture {
                        product.isFavorite.toggle()
                        CartManager.shared.updateProductIsFavorite(productID: product.id, isFavorite: product.isFavorite) { result in
                            switch result {
                            case .success():
                                print("Product isFavorite updated successfully")
                            case .failure(let error):
                                print("Error updating product isFavorite: \(error.localizedDescription)")
                            }
                        }
                    }
                    .foregroundColor(product.isFavorite ? .red : .black)
                    .padding(10),
                alignment: .topTrailing
            )
            Text(product.name)
                .font(.system(size: 14, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(product.price) ₸")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            if count >= 1 {
                HStack {
                    Button(action: {
                        if count > 0 {
                            count -= 1
                            CartManager.shared.updateProductCount(product: product, newCount: count) { result in
                                switch result {
                                case .success():
                                    print("Product count updated successfully")
                                case .failure(let error):
                                    print("Error updating product count: \(error.localizedDescription)")
                                }
                            }
                        }
                    }) {
                        Image(systemName: "minus")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .padding(screenSize.width * 0.025)
                    
                    VStack {
                        Text("\(count)")
                        Text(product.isKilo ? "кг" : "шт")
                    }
                    .font(.system(size: 11, weight: .heavy))
                    
                    Button(action: {
                        if count < product.maxCount {
                            count += 1
                            CartManager.shared.updateProductCount(product: product, newCount: count) { result in
                                switch result {
                                case .success():
                                    print("Product count updated successfully")
                                case .failure(let error):
                                    print("Error updating product count: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            print("Maximum count of \(product.name)")
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .padding(screenSize.width * 0.025)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: screenSize.height * 0.04)
                .background(Color.green)
                .cornerRadius(screenSize.height * 0.04)
            } else {
                HStack {
                    Text("\(product.price) ₸")
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Button(action: {
                        count += 1
                        CartManager.shared.addProductToCart(product: product) { result in
                            switch result {
                            case .success():
                                print("Product added to cart successfully")
                            case .failure(let error):
                                print("Error adding product to cart: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: screenSize.height * 0.04)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(screenSize.height * 0.04)
            }
        }
        .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.3)
        .padding(screenSize.width * 0.01)
        .onAppear {
            CartManager.shared.getProductCount(productID: product.id) { result in
                switch result {
                case .success(let fetchedCount):
                    count = fetchedCount
                case .failure(let error):
                    print("Error fetching product count: \(error.localizedDescription)")
                }
            }
            
            CartManager.shared.checkIsFavorite(productID: product.id) { result in
                switch result {
                case .success(let isFavorite):
                    product.isFavorite = isFavorite
                case .failure(let error):
                    print("Error fetching product isFavorite: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var products: [Product] = []
    
    var body: some View {
        VStack {
            ForEach(products) { product in
                ProductCardView(product: product)
            }
        }
        .onAppear {
            CartManager.shared.getAllProducts { result in
                switch result {
                case .success(let fetchedProducts):
                    products = fetchedProducts
                case .failure(let error):
                    print("Error fetching products: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

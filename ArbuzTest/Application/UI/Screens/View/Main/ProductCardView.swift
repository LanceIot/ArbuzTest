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
                Image(systemName: product.isFavorite ? "heart.fill": "heart")
                    .onTapGesture {
                        product.isFavorite.toggle()
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
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                }
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: screenSize.height * 0.04)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(screenSize.height * 0.04)
                .onTapGesture {
                    print("\(count)")
                    count+=1
                }
            }
        }
        .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.3)
        .padding(screenSize.width * 0.01)
    }
}

#Preview {
    ProductCardView(product: Product(
            id: UUID(),
            name: "Огурцы Рава Степногорск кг",
            price: 2444,
            isFavorite: false,
            isKilo: true,
            minCount: 1,
            maxCount: 20,
            imageUrl: "png",
            description: "Огурцы обладают определенными лечебными свойствами: повышают аппетит, способствуют хорошему усвоению пищи."
        )
    )
}


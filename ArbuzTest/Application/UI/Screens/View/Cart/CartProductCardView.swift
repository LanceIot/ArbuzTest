//
//  CarProductCardView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

struct CartProductCardView: View {
    
    @State var product: Product
    @State private var count: Int = 1
    
    private let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        HStack {
            ZStack {
                Image("png")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .background(Color(UIColor.systemGray5))
            .frame(maxWidth: screenSize.width * 0.25, maxHeight: screenSize.width * 0.25)
            .cornerRadius(10)
            .overlay(
                Image(systemName: product.isFavorite ? "heart.fill": "heart")
                    .onTapGesture {
                        product.isFavorite.toggle()
                    }
                    .foregroundColor(product.isFavorite ? .red : .black)
                    .padding(5),
                alignment: .topTrailing
            )
            VStack(alignment: .leading) {
                Text("\(product.name)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, screenSize.width * 0.06)
                    .font(.system(size: 14))
                Text("\(product.price) ₸/\(product.isKilo ? "кг" : "шт")")
                    .font(.system(size: 14))
                    .foregroundColor(Color(UIColor.systemGray3))
                Spacer()
                HStack {
                    HStack {
                        if count > 1 {
                            Button(action: {
                                if count > 1 {
                                    count -= 1
                                }
                            }) {
                                Image(systemName: "minus")
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(screenSize.width * 0.01)
                            }
                            .padding(screenSize.width * 0.02)
                            .padding(.leading, screenSize.width * 0.02)
                        } else {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "trash")
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(screenSize.width * 0.01)
                            }
                            .padding(screenSize.width * 0.02)
                            .padding(.leading, screenSize.width * 0.02)
                        }
                        
                        VStack {
                            Text("\(count)")
                                .font(.system(size: 14, weight: .bold))
                            if product.isKilo {
                                Text("кг")
                                    .font(.system(size: 10, weight: .regular))
                                    .italic()
                            }
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
                                .font(.system(size: 16, weight: .medium))
                                .padding(screenSize.width * 0.01)
                        }
                        .padding(screenSize.width * 0.02)
                        .padding(.trailing, screenSize.width * 0.02)
                        .disabled(count >= product.maxCount)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: screenSize.width * 0.33, maxHeight: screenSize.height * 0.037)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(screenSize.height * 0.04)
                    
                    Spacer()
                    
                    Text("\(product.price * count) ₸")
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: screenSize.height * 0.1)
        .padding(.vertical, screenSize.height * 0.01)
        .overlay(
            Image(systemName: "xmark")
                .foregroundColor(Color(UIColor.systemGray5))
                .padding(10),
            alignment: .topTrailing
        )
//        .background(Color.gray)
    }
}

#Preview {
    CartProductCardView(product: Product(
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

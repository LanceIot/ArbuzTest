//
//  CardView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel: CartViewModel
    
    var totalCost: Int = 256
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                        Button(action: {
                            viewModel.getCartProducts()
                        }, label: {
                            Text("Retry")
                        })
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        if totalCost < 8000 {
                            HStack {
                                Image(systemName: "truck.box")
                                    .font(.system(size: 18, weight: .bold))
                                Text("До бесплатной доставки \(8000 - totalCost) ₸")
                                    .font(.system(size: 18, weight: .medium))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 28)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                        }
                        
                        LazyVStack {
                            ForEach(viewModel.cartProducts) { product in
                                CartProductCardView(product: product)
                                Divider()
                            }
                        }
                    }
                    .overlay(
                        VStack {
                            Text("Перейти к оплате")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text("\(totalCost) ₸")
                        }
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(Color(UIColor.systemGreen).opacity(0.9))
                            .cornerRadius(15)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25),
                        alignment: .bottom
                    )
                }
            }
            .padding(5)
            .navigationTitle("Корзина")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                print("Кнопка Очистить pressed")
            }) {
                Text("Очистить")
                    .font(.system(size: 14))
                    .foregroundColor(Color(UIColor.systemGray2))
            }
            )
        }
        .onAppear(perform: {
            viewModel.getCartProducts()
        })
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}

//
//  CardView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel: CartViewModel
    
    @State private var totalCost: Int = 0

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
                            viewModel.getCartProducts() {
                                updateTotalCost()
                            }
                        }, label: {
                            Text("Retry")
                                .padding()
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
                                CartProductCardView(removedCell: {
                                    viewModel.getCartProducts {
                                        updateTotalCost()
                                    }
                                }, product: product)
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
        }
        .onAppear(){
            viewModel.getCartProducts {
                updateTotalCost()
            }
        }
    }
    
    private func updateTotalCost() {
        totalCost = viewModel.cartProducts.reduce(0) { $0 + $1.price * $1.count }
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}

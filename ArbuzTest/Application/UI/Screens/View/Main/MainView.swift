//
//  MainView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
        
    let hLayout = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.5), spacing: UIScreen.main.bounds.width * 0.05)]
    let vLayout = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.2), spacing: UIScreen.main.bounds.width * 0.05)]
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                        .foregroundColor(.black)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        Section(header:
                                    Text("Popular")
                            .font(.system(size: 18, weight: .bold))
                        ) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: hLayout, spacing: UIScreen.main.bounds.width * 0.002) {
                                    ForEach(viewModel.products) { product in
                                        ProductCardView(product: product)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        Section(header:
                                    Text("All")
                            .font(.system(size: 18, weight: .bold))
                        ) {
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                LazyVGrid(columns: vLayout, spacing: UIScreen.main.bounds.width * 0.05) {
                                    ForEach(viewModel.products) { product in
                                        ProductCardView(product: product)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    
                }
            }
            .onAppear(perform: viewModel.loadProducts)
        }
        .navigationTitle("Products")
    }
}

#Preview {
    MainView()
}


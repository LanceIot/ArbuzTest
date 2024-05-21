//
//  DetailView.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    @State private var count: Int = 0
    
    var screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if viewModel.product.imageUrl != "" {
                        Image(viewModel.product.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                            .padding()
                    }
                    Text(viewModel.product.name)
                        .font(.system(size: 22, weight: .bold))
                        .padding(5)
                    Text("\(viewModel.product.price) ₸/\(viewModel.product.isKilo ? "кг" : "шт")")
                        .font(.system(size: 18, weight: .regular))
                    VStack {
                        Text("Описание")
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom, 5)
                            .padding(.horizontal)
                        Text(viewModel.product.description)
                            .font(.system(size: 20, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.vertical)
                    
                }
            }
            
            .background(Color(UIColor.systemGray6))
            .navigationBarItems(
                leading:
                    Button(action: {
                        print("Button Close pressed")
                    }) {
                        Image(systemName: "xmark")
                            .onTapGesture {
                                
                            }
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    },
                
                trailing:
                    Button(action: {
                        print("Button Heart pressed")
                    }) {
                        Image(systemName: viewModel.product.isFavorite ? "heart.fill": "heart")
                            .onTapGesture {
                                viewModel.product.isFavorite.toggle()
                            }
                            .foregroundColor(viewModel.product.isFavorite ? .red : .black)
                            .font(.system(size: 22))
                    })
        }
        .onAppear() {
            viewModel.loadProduct()
        }
        .overlay(
            HStack {
                if count >= 1 {
                    Button(action: {
                        if count >= 1 {
                            count -= 1
                        }
                    }, label: {
                        Image(systemName: "minus")
                            .font(.system(size: 30, weight: .medium))
                            .padding(screenSize.width * 0.06)
                    })
                    .foregroundColor(.white)
                    .padding(.vertical, screenSize.width * 0.03)
                    .padding(.horizontal, screenSize.width * 0.05)
                }
                
                Spacer()
                
                VStack {
                    Text("\(count <= 1 ? viewModel.product.price : viewModel.product.price * count) ₸")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text("\(count < 1 ? "за \(count+1)" : "\(count)") \(viewModel.product.isKilo ? "кг" : "шт")")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {
                    if count < viewModel.product.maxCount {
                        count += 1
                    } else {
                        print("Maximum count of \(viewModel.product.name)")
                    }
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .medium))
                        .padding(screenSize.width * 0.06)
                })
                .foregroundColor(.white)
                .padding(.vertical, screenSize.width * 0.01)
                .padding(.horizontal, screenSize.width * 0.05)
            }
                .frame(maxWidth: .infinity, maxHeight: 80)
                .background(Color(UIColor.systemGreen))
                .ignoresSafeArea(),
            alignment: .bottom
        )
        .ignoresSafeArea()
        
        
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(id: UUID.init(uuidString: "8f8f7d30-77a8-4e6d-9a3f-53fdda12d291") ?? UUID()))
}

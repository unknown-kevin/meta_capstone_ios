//
//  DishDetail.swift
//  iOS Meta Capstone Project
//
//  Created by Cristina on 2023-09-15.
//

import SwiftUI

struct DishDetail: View {
    // MARK: PROPERTIES
    
    let dish: Dish

    // MARK: BODY
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dish.image ?? "")){
                image in image
                    .resizable()
                    .scaledToFill()
                    .frame(width:350, height: 100)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .scaledToFit()
            .padding()
            
            Text("\(dish.dishDescription ?? "")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("MarkaziText-Regular", size: 16))
                .padding(.leading, 20)

            Text("€\(dish.price ?? "").00")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.medium)
                .padding(2)
                .padding(.leading, 20)

        }
        .navigationBarTitle(Text(dish.title ?? ""), displayMode: .inline)
    }
}


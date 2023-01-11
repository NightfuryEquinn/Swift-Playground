//
//  ContentView.swift
//  FoodOrderingSystem
//
//  Created by YIP ZI XIAN on 11/01/2023.
//

import SwiftUI

// Provide UI of the screen
struct ContentView: View {
    var body: some View {
        List {
            CategoryView(imageName: "burger", categoryName: "BURGER")
            CategoryView(imageName: "pasta", categoryName: "PASTA")
            CategoryView(imageName: "pizza", categoryName: "PIZZA")
            CategoryView(imageName: "desserts", categoryName: "DESSERTS")
        }
    }
}

struct CategoryView: View {
    
    let imageName: String
    let categoryName: String
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 275.0, height: 150.0)
                    .clipped()
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                Text(categoryName)
                    .font(.custom("HelveticaNeue-Medium", size: 50))
                    .foregroundColor(Color.white)
            }
            Spacer()
        }
        .padding(.top, 5.0)
        .padding(.bottom, 5.0)
    }
}

// Provide Preview of the screen
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

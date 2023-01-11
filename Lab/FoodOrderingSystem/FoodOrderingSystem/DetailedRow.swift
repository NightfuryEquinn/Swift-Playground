//
//  DetailedRow.swift
//  FoodOrderingSystem
//
//  Created by YIP ZI XIAN on 11/01/2023.
//

import SwiftUI

struct DetailedRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading)
            {
                Text("BBQ Burger")
                    .font(.headline)
                    .padding(.top, 10)
                Text("RM 10.00")
                    .font(.caption)
            }
            
            Spacer()
            
            Button(action: {
                print("Order received.")
            }) {
                Text("ORDER")
                    .foregroundColor(Color.white)
            }
            .frame(width: 80, height: 50)
            .background(Color.orange)
            .cornerRadius(10)
        }
        .padding(20)
    }
}

struct DetailedRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailedRow()
    }
}

//
//  SearchBar.swift
//  CoreDataSwift
//
//  Created by YIP ZI XIAN on 15/02/2023.
//

import SwiftUI

struct SearchBar: View {
    var rowHeight: CGFloat = 50
    
    // Require a property to bind to the TextField
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.lightGray))
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Task ...", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.black)
            .padding(.leading, 13)
        }
        .frame(height: rowHeight * 0.75)
        .cornerRadius(13)
        .padding()
    }
}

// SearchBar_Previews that will always be the same size as SearchBar view
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), searching: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}

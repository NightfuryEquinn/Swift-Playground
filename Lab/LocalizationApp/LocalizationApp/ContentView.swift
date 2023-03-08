//
//  ContentView.swift
//  LocalizationApp
//
//  Created by YIP ZI XIAN on 08/03/2023.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding()
            Text("helloWorld")
                .padding()
            VideoPlayer(player: AVPlayer(url: URL(string: "https://bit.ly/swswift")!))
                .frame(height: 400)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

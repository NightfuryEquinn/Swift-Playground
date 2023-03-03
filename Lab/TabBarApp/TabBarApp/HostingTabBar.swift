//
//  HostingTabBar.swift
//  TabBarApp
//
//  Created by YIP ZI XIAN on 03/03/2023.
//

import SwiftUI

struct HostingTabBar: View {
    private enum Tab: Hashable {
        case wine
        case grapes
        case soil
        case setting
    }
    
    @State private var selectedTab: Tab = .wine
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Wine()
                .tag(0)
                .tabItem {
                    Text("Wine")
                    Image(systemName: "house.fill")
                }
            Grapes()
                .tag(1)
                .tabItem {
                    Text("Grapes")
                    Image(systemName: "magnifyingglass")
                }
            Soil()
                .tag(2)
                .tabItem {
                    Text("Soil")
                    Image(systemName: "person.crop.circle")
                }
            Setting()
                .tag(3)
                .tabItem {
                    Text("Setting")
                    Image(systemName: "gear")
                }
        }
    }
}

struct HostingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HostingTabBar()
    }
}

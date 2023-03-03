//
//  MyMap.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 15/02/2023.
//

import SwiftUI
import MapKit

struct MyMapView: View {
    // Some Map will not have a pin annotation at launch so make it optional
    @State var currentAnnotation: MKPointAnnotation?
    
    // Declare for Flickr API to control when the model view should be opened
    @State var showPhotoGrid = false
    
    @EnvironmentObject var myMapLocationManager: MyMapLocationManager
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                // Binding to let MyMap to zoom to current region
                // Binding parameter according to order
                MyMap(currentRegion: $myMapLocationManager.currentRegion, currentAnnotation: $currentAnnotation, showPhotoGrid: $showPhotoGrid)
                
                Button(action: {
                    myMapLocationManager.goToUserLocation()
                    print("Go to user location.")
                }) {
                    LocationButtonContent()
                }
            }
                .sheet(isPresented: $showPhotoGrid, content: {
                    PhotoGrid(
                        latitudeToSearchFor: (currentAnnotation?.coordinate.latitude)!,
                        longitudeToSearchFor: (currentAnnotation?.coordinate.longitude)!
                    )
                })
                .navigationBarTitle("Long-press to drop pin", displayMode: .inline)
                .edgesIgnoringSafeArea(.all) // Ignore safe area to cover the whole screen
        }
    }
}

struct LocationButtonContent: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
            Image(systemName: "location")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .clipped()
                .foregroundColor(.black)
                .padding(40)
        }
    }
}

struct MyMapView_Previews: PreviewProvider {
    static var previews: some View {
        MyMapView().environmentObject(MyMapLocationManager())
    }
}

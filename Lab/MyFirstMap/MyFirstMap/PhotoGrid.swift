//
//  PhotoGrid.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 03/03/2023.
//

import SwiftUI

struct PhotoGrid: View {
    var latitudeToSearchFor: Double
    var longitudeToSearchFor: Double
    
    @StateObject var downloadManager = DownloadManager()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                // LazyVGrid always have two columns with no spacing
                LazyVGrid(columns: [GridItem(spacing: 0), GridItem(spacing: 0)], spacing: 0) {
                    ForEach(downloadManager.downloadedImages) { downloadedImage in
                        GridCell(image: UIImage(imageLiteralResourceName: "sampleImage"), width: geometry.size.width / 2, height: geometry.size.width / 2)
                    }
                }
            }
        }
            .onAppear(perform: {
                downloadManager.startDownload(flickrURL: generateFlickrURL(latitude: latitudeToSearchFor, longitude: longitudeToSearchFor, numberOfPhotos: 40))
            })
            .onDisappear(perform: {
                downloadManager.clean()
            })
    }
}

struct GridCell: View {
    let image: UIImage
    let width, height: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipped()
    }
}

struct PhotoGrid_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGrid(latitudeToSearchFor: 48.864716, longitudeToSearchFor: 2.349014)
    }
}

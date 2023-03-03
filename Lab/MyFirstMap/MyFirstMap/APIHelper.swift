//
//  APIHelper.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 03/03/2023.
//

import Foundation

let apiKey = "f707871e9fd9a469d87fdfc9c281c572"

func generateFlickrURL(latitude: Double, longitude: Double, numberOfPhotos: Int) -> String {
    let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_ke y=\(apiKey)&lat=\(latitude)&lon=\(longitude)&radius=1&radius_units=km&per_page=\(numberOfPhotos)&format=json&nojsoncallback=1"
    
    return url
}

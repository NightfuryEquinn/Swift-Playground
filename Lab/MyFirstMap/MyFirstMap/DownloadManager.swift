//
//  DownloadManager.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 03/03/2023.
//

import Foundation
import SwiftUI
import Alamofire
import AlamofireImage

// Alamofire to execute web requests with generated URL and retrieve the returned JSON file
// AlamofireImage to download individual images

class DownloadManager: ObservableObject {
    @Published var imagesFetched = false
    
    var imageURLs = [String]()
    var downloadedImages = [DownloadedImage]()
    
    func startDownload(flickrURL: String) {
        print("Started fetching images from Flickr")
        
        retrieveImageURLS(fromFlickrURL: flickrURL) { (finished) in
            if finished {
                print("All image URLs retrieved")
                
                self.retrieveImages { (finished) in
                    if finished {
                        print("All images successfully downloaded.")
                        self.imagesFetched = true
                    }
                }
            }
        }
    }
    
    // Use the given URL to receive JSON data using Alamofire
    // Convert JSON into Swift Dict and work through JSON tree structure by extracting the first subdictionary named "photos"
    // The subdict contains multiple dicts called "photo", use the value to build each image URL, then add to imageURL array
    // After all URLs generated from received JSON, tell the function's caller that one is done by setting the @escaping status to true
    func retrieveImageURLS(fromFlickrURL: String, handler: @escaping (_ status: Bool) -> ()) {
        AF.request(fromFlickrURL).responseJSON { (response) in
            switch response.result {
                
            case let .success(value):
                if let json = value as? Dictionary<String, AnyObject> {
                    let motherPhotosDict = json["photos"] as! Dictionary<String, AnyObject>
                    let photoDicts = motherPhotosDict["photo"] as! [Dictionary<String, AnyObject>]
                    
                    for photo in photoDicts {
                        let photoURL = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_b.jpg"
                        
                        self.imageURLs.append(photoURL)
                    }
                    
                    handler(true)
                }
                
            case let .failure(error):
                print("JSON could not be created", error)
            }
        }
    }
    
    func retrieveImages(handler: @escaping(_ status: Bool) -> ()) {
        guard !imageURLs.isEmpty else { return handler(true) }
        
        for url in imageURLs {
            AF.request(url).responseImage { (response) in
                switch response.result {
                    
                case let .success(retrievedImage):
                    self.downloadedImages.append(DownloadedImage(image: retrievedImage))
                    
                    print("\(self.downloadedImages.count)/\(self.imageURLs.count) images downloaded.")
                    
                    if self.downloadedImages.count == self.imageURLs.count {
                        handler(true)
                    }
                    
                case let .failure(error):
                    print("Image could not be fetched from \(url).", error)
                }
            }
        }
    }
    
    func clean() {
        imageURLs.removeAll()
        downloadedImages.removeAll()
    }
}

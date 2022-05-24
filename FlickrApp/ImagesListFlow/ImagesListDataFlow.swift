//
//  ImagesListDataFlow.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation

enum ImagesList {
    enum Output {
        case seatchHistory(ImagesListStorageProtocol)
        case errorAlert(String)
    }
    
    struct Request {
        let searchText: String
    }
    
    enum Response {
        struct List {
            let searchText: String
            let images: [FlickrImage]
        }
        
        struct Image {
            let index: Int
            let imageModel: FlickrImage
        }
    }
}

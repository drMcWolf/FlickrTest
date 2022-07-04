//
//  ImagesListDataFlow.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation

enum ImagesList {
    enum Output: Equatable {
        case searchHistory(ImagesListStorageProtocol)
        case errorAlert(String)
        
        static func == (lhs: ImagesList.Output, rhs: ImagesList.Output) -> Bool {
            switch (lhs, rhs) {
            case (.searchHistory, .searchHistory):
                return true
            case let (.errorAlert(lMessage), .errorAlert(rMessage)):
                return lMessage == rMessage
            default:
                return false
            }
        }
    }
    
    struct Request: Equatable {
        let searchText: String
    }
    
    enum Response {
        struct List {
            let searchText: String
            let images: [FlickrImage]
        }
        
        struct Image: Equatable {
            let index: Int
            let imageModel: FlickrImage
        }
    }
}

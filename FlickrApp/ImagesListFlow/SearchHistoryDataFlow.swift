//
//  SearchHistoryDataFlow.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import Foundation

enum SearchHistory {
    enum Output {
        case select(SearchItem)
    }
    
    struct Request {
        
    }
    
    struct Response {
        let items: [SearchItem]
    }
}

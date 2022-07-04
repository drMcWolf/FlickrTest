//
//  SearchHistoryDataFlow.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import Foundation

enum SearchHistory {
    enum Output: Equatable {
        case select(SearchItemProtocol)
        static func == (lhs: SearchHistory.Output, rhs: SearchHistory.Output) -> Bool {
            switch (lhs, rhs) {
            case let (.select(lItem), .select(rItem)):
                return lItem.date == rItem.date && rItem.text == rItem.text
            }
        }
    }
    
    struct Request: Equatable {
        
    }
    
    struct Response: Equatable {
        let items: [SearchItemProtocol]
        
        static func == (lhs: SearchHistory.Response, rhs: SearchHistory.Response) -> Bool {
            if lhs.items.count != rhs.items.count {
                return false
            }
            var isEqual = false
            
            lhs.items.enumerated().forEach {
                isEqual = $0.element.date == rhs.items[$0.offset].date && $0.element.text == rhs.items[$0.offset].text
            }
            return isEqual
        }
    }
}

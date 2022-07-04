//
//  SearchHistoryInteractorMock.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class SearchHistoryInteractorMock: SearchHistoryBusinessLogic {
    var obtainWasCalled: Int = 0
    var passedRequest: SearchHistory.Request?
    
    func obtainInitialState(request: SearchHistory.Request) {
        passedRequest = request
        obtainWasCalled += 1
    }
    
    var selectWasCalled: Int = 0
    var passedIndex: Int?
    
    func selectItem(at index: Int) {
        selectWasCalled += 1
        passedIndex = index
    }
}

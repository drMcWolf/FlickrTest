//
//  SearchHistoryPresenterMock.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class SearchHistoryPresenterMock: SearchHistoryPresentationLogic {
    var presentWasCalled: Int = 0
    var passedResponse: SearchHistory.Response?
    
    func present(response: SearchHistory.Response) {
        passedResponse = response
        presentWasCalled += 1
    }
}

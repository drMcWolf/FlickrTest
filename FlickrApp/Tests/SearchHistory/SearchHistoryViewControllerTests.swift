//
//  SearchHistoryViewControllerTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

class SearchHistoryViewControllerTests: XCTestCase {
    func testViewDidLoad() {
        // given
        
        let interactorMock = SearchHistoryInteractorMock()
        let viewController = SearchHistoryViewController(interactor: interactorMock)
        
        // when
        
        viewController.loadViewIfNeeded()
        
        // then
        
        XCTAssert(interactorMock.obtainWasCalled == 1, "The method should be called once")
        XCTAssert(interactorMock.passedRequest == SearchHistory.Request(), "The requests should match")
    }
    
    func testSelect() {
        // given
        
        let interactorMock = SearchHistoryInteractorMock()
        let viewController = SearchHistoryViewController(interactor: interactorMock)
        
        // when
        
        viewController.selectItem(at: 3)
        
        // then
        
        XCTAssert(interactorMock.selectWasCalled == 1, "The method should be called once")
        XCTAssert(interactorMock.passedIndex == 3, "The indexes should match")
    }
}

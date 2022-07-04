//
//  ImagesListViewControllerTest.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

class ImagesListViewControllerTest: XCTestCase {
    func testViewDidLoad() {
        // given
        let interactorMock = ImagesListInteractorMock()
        let viewController = ImagesListViewController(interactor: interactorMock)
        
        // when
        viewController.loadViewIfNeeded()
        
        // then
        XCTAssert(interactorMock.obtainImagesWasCalled == 1, "The method should be called once")
        XCTAssert(interactorMock.passedListRequest == TestData.requestEmpty, "The requests should match")
    }
  
    func testSearch() {
        // given
        let interactorMock = ImagesListInteractorMock()
        let viewController = ImagesListViewController(interactor: interactorMock)
        
        // when
        viewController.search(with: TestData.searchText)
        
        // then
        XCTAssert(interactorMock.obtainImagesWasCalled == 1, "The method should be called once")
        XCTAssert(interactorMock.passedListRequest == TestData.requestWithText, "The requests should match")
    }
    
    func testWillDisplayItem() {
        // given
        let interactorMock = ImagesListInteractorMock()
        let viewController = ImagesListViewController(interactor: interactorMock)
        
        // when
        viewController.willDisplayItem(at: 1)
        
        // then
        XCTAssert(interactorMock.startLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(interactorMock.passedLoadingIndex == 1, "The indexes should match")
    }
    
    func testDidDisplayItem() {
        // given
        let interactorMock = ImagesListInteractorMock()
        let viewController = ImagesListViewController(interactor: interactorMock)
        
        // when
        viewController.didDisplayItem(at: 1)
        
        // then
        XCTAssert(interactorMock.stopLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(interactorMock.passedStopIndex == 1, "The indexes should match")
    }
}

private extension ImagesListViewControllerTest {
    enum TestData {
        static let requestWithText = ImagesList.Request(searchText: searchText)
        static let searchText = "Search text"
        static let requestEmpty = ImagesList.Request(searchText: "")
    }
}

//
//  SearchHistoryInteractorTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

class SearchHistoryInteractorTests: XCTestCase {

    func testObtainInitialState() {
        // given
        let presenterMock = SearchHistoryPresenterMock()
        let storageMock = ImagesListStorageMock()
        let outputMock = SearchHistoryOutputMock()
        
        storageMock.fetchResultStub = TestData.models
        
        let interactor = SearchHistoryInteractor(
            with: presenterMock,
            storage: storageMock,
            output: outputMock
        )
        
        // when
        interactor.obtainInitialState(request: .init())
        
        // then
        XCTAssert(storageMock.fetchSearchHistoryWasCalled == 1, "The method should be called")
        XCTAssert(presenterMock.presentWasCalled == 1, "The method should be called")
        XCTAssert(presenterMock.passedResponse == TestData.response, "The response should match")
    }
    
    func testSelectItem() {
        // given
        let presenterMock = SearchHistoryPresenterMock()
        let storageMock = ImagesListStorageMock()
        let outputMock = SearchHistoryOutputMock()
        
        storageMock.fetchResultStub = TestData.models
        
        let interactor = SearchHistoryInteractor(
            with: presenterMock,
            storage: storageMock,
            output: outputMock
        )
        
        // when
        interactor.selectItem(at: 1)
        
        // then
        XCTAssert(storageMock.fetchSearchHistoryWasCalled == 1, "The method should be called")
        XCTAssert(outputMock.handleWasCalled == 1, "The method should be called")
        XCTAssert(outputMock.passedOutput == .select(TestData.models[1]), "The method should be called")
    }
    
}

private extension SearchHistoryInteractorTests {
    enum TestData {
        static let models = [
            SearchItemMock(date: Date(), text: "text1"),
            SearchItemMock(date: Date(), text: "text2"),
            SearchItemMock(date: Date(), text: "text3"),
            SearchItemMock(date: Date(), text: "text4"),
            SearchItemMock(date: Date(), text: "text5")
        ]
        static let response = SearchHistory.Response(items: models)
    }
}

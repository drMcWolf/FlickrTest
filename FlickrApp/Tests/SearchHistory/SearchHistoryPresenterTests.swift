//
//  SearchHistoryPresenterTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

class SearchHistoryPresenterTests: XCTestCase {
    
    
    func testPresent() {
        // given
        
        let viewControllerMock = SearchHistoryViewControllerMock()
        let presenter = SearchHistoryPresenter()
        presenter.viewController = viewControllerMock
        
        // when
        presenter.present(response: TestData.response)
        
        // then
        
        XCTAssert(viewControllerMock.displayWasCalled == 1, "The method should be called once")
        XCTAssert(viewControllerMock.passedViewModel == TestData.viewModel, "The viewModels should match")
    }

}

private extension SearchHistoryPresenterTests {
    enum TestData {
        private static var formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            return formatter
        }()
        static let viewModel = SearchHistoryView.ViewModel(items: models.map { .init(title: $0.text!, details: formatter.string(from: $0.date!)) })
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

//
//  SearchHistoryOutputMock.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class SearchHistoryOutputMock: SearchHistoryOutput {
    var handleWasCalled: Int = 0
    var passedOutput: SearchHistory.Output?
    
    func handle(output: SearchHistory.Output) {
        passedOutput = output
        handleWasCalled += 1
    }
}

//
//  SearchHistoryViewControllerMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class SearchHistoryViewControllerMock: SearchHistoryDisplayLogic {
    var displayWasCalled: Int = 0
    var passedViewModel: SearchHistoryView.ViewModel?
    
    func display(viewModel: SearchHistoryView.ViewModel) {
        passedViewModel = viewModel
        displayWasCalled += 1
    }
}

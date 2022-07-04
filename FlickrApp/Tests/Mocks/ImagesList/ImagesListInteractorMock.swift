//
//  ImagesListInteractorMock.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class ImagesListInteractorMock: ImagesListBusinessLogic {
    var obtainImagesWasCalled: Int = 0
    var passedListRequest: ImagesList.Request?
    
    func obtainImagesList(request: ImagesList.Request) {
        obtainImagesWasCalled += 1
        passedListRequest = request
    }
    
    var startLoadingWasCalled: Int = 0
    var passedLoadingIndex: Int?
    func startLoadingImage(for index: Int) {
        passedLoadingIndex = index
        startLoadingWasCalled += 1
    }
    
    var stopLoadingWasCalled: Int = 0
    var passedStopIndex: Int?
    
    func stopLoadinImage(for index: Int) {
        stopLoadingWasCalled += 1
        passedStopIndex = index
    }
    
    var onSearchHistoryWasCalled: Int = 0
    
    func onSearchHistory() {
        onSearchHistoryWasCalled += 1
    }
}

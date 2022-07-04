//
//  ImagesListPresenterMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class ImagesListPresenterMock: ImagesListPresentationLogic {
    var presentResponseListWasCalled: Int = 0
    var passedResponseList: ImagesList.Response.List = .init(searchText: "", images: [])
    
    func present(response: ImagesList.Response.List) {
        presentResponseListWasCalled += 1
        passedResponseList = response
    }
    
    var presentResponseImageWasCalled: Int = 0
    var passedResponseImage: ImagesList.Response.Image?
    
    func present(response: ImagesList.Response.Image) {
        presentResponseImageWasCalled += 1
        passedResponseImage = response
    }
    
    var presentLoadingWasCalled: Int = 0
    
    func presentLoading() {
        presentLoadingWasCalled += 1
    }
    
    var hideLoadingWasCalled: Int = 0
    
    func hideLoading() {
        hideLoadingWasCalled += 1
    }    
}

//
//  ApiServiceMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import UIKit
@testable import FlickrApp

final class ApiServiceMock: ApiServiceProtocol {
    var passedSearchText: String = ""
    var passedPage: Page = .init(pageNumber: 0)
    var getPicturesWasCalled: Int = 0
    var getPicturesResultStub: Result<FlickrImageSearchDTO, Error>?
    
    func getPictures(searchText: String, page: Page, completion: @escaping (Result<FlickrImageSearchDTO, Error>) -> Void) {
        passedSearchText = searchText
        passedPage = page
        getPicturesWasCalled += 1
        if let getPicturesResultStub = getPicturesResultStub {
            completion(getPicturesResultStub)
        }
    }
    
    var passedImageId: String = ""
    var downloadPictureWasCalled: Int = 0
    var downloadPictureResultStub: Result<UIImage, Error>?
    
    func downloadPicture(for id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        downloadPictureWasCalled += 1
        passedImageId = id
        if let downloadPictureResultStub = downloadPictureResultStub {
            completion(downloadPictureResultStub)
        }
    }    
}

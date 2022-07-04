//
//  ImagesListServiceMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import UIKit
@testable import FlickrApp

final class ImagesListServiceMock: ImagesListServiceProtocol {
    var obtainWasCalled: Int = 0
    var resultStub: Result<[FlickrImage], Error>?
    var passedSearchText: String = ""
    var passedPage: Page = .init(pageNumber: 0)
    func obtainImagesList(searchText: String, page: Page, completion: @escaping (Result<[FlickrImage], Error>) -> Void) {
        passedPage = page
        passedSearchText = searchText
        obtainWasCalled += 1
        if let resultStub = resultStub {
            completion(resultStub)
        }
    }
    
    var dowloadWasCalled: Int = 0
    var passedImageModel: FlickrImage?
    var downloadResultStub: Result<UIImage, Error>?
    
    func download(imageModel: FlickrImage, completion: @escaping (Result<UIImage, Error>) -> Void) {
        passedImageModel = imageModel
        dowloadWasCalled += 1
        if let downloadResultStub = downloadResultStub {
            completion(downloadResultStub)
        }
    }
}

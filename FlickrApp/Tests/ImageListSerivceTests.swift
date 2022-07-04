//
//  ImageListSerivceTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

final class ImageListSerivceTests: XCTestCase {
    func testObtainSuccess() {
        // given
        let apiMock = ApiServiceMock()
        let service = ImagesListService(with: apiMock)
        apiMock.getPicturesResultStub = .success(TestData.searchDto)
        
        // when
        service.obtainImagesList(searchText: TestData.searchText, page: TestData.page) { result in
            switch result {
            case let .success(models):
                XCTAssert(models == TestData.models, "The dto model should not be changed")
            case .failure:
                XCTAssert(false, "The failure statement should not be called")
            }
        }
        
        // then
        XCTAssert(apiMock.getPicturesWasCalled == 1, "The apiMock method should be called once")
        XCTAssert(apiMock.passedSearchText == TestData.searchText, "The search text should not be changed")
        XCTAssert(apiMock.passedPage == TestData.page, "The page should not be changed")
    }
    
    func testObtainFailure() {
        // given
        let apiMock = ApiServiceMock()
        let service = ImagesListService(with: apiMock)
        apiMock.getPicturesResultStub = .failure(TestData.error)
        
        // when
        service.obtainImagesList(searchText: TestData.searchText, page: TestData.page) { result in
            switch result {
            case .success:
                XCTAssert(false, "The success statement should not be called")
            case let .failure(error):
                XCTAssert(error as NSError == TestData.error, "The error should not be changed")
            }
        }
        
        // then
        XCTAssert(apiMock.getPicturesWasCalled == 1, "The apiMock method should be called once")
        XCTAssert(apiMock.passedSearchText == TestData.searchText, "The search text should not be changed")
        XCTAssert(apiMock.passedPage == TestData.page, "The page should not be changed")
    }
    
    func testDownloadImageSuccess() {
        // given
        let apiMock = ApiServiceMock()
        let service = ImagesListService(with: apiMock)
        apiMock.downloadPictureResultStub = .success(TestData.image)
        
        // when
        service.download(imageModel: TestData.singleImageModel) { result in
            switch result {
            case let .success(image):
                XCTAssert(image == TestData.image, "The image should not be changed")
            case .failure:
                XCTAssert(false, "The failure statement should not be called")
            }
        }
        // then
        XCTAssert(apiMock.passedImageId == TestData.singleImagePath, "The image path contains error")
        XCTAssert(apiMock.downloadPictureWasCalled == 1, "The download method should be called once")
    }
    
    func testDownloadImageFailure() {
        // given
        let apiMock = ApiServiceMock()
        let service = ImagesListService(with: apiMock)
        apiMock.downloadPictureResultStub = .failure(TestData.error)
        
        // when
        service.download(imageModel: TestData.singleImageModel) { result in
            switch result {
            case .success:
                XCTAssert(false, "The success statement should not be called")
            case let .failure(error):
                XCTAssert(error as NSError == TestData.error, "The error should not be changed")
            }
        }
        // then
        XCTAssert(apiMock.passedImageId == TestData.singleImagePath, "The image path contains error")
        XCTAssert(apiMock.downloadPictureWasCalled == 1, "The download method should be called once")
    }

}

private extension ImageListSerivceTests {
    enum TestData {
        static let image = UIImage()
        static let error = NSError(domain: "Some domain", code: -1)
        static let searchText = "Some search text"
        static let page = Page(pageNumber: 150)
        static let searchDto = FlickrImageSearchDTO(photo: [
            .init(id: "52191358602", secret: "5586d30a64", server: "65535"),
            .init(id: "52191359307", secret: "3d81e448b8", server: "65535"),
            .init(id: "52191359782", secret: "469dfdd762", server: "65535"),
            .init(id: "52191359877", secret: "649ffb50b4", server: "65535"),
            .init(id: "52192368846", secret: "1b55023593", server: "65535")
        ])
        static let models: [FlickrImage] = searchDto.photo.map { FlickrImage(id: $0.id, secret: $0.secret, server: $0.server) }
        static let singleImageModel = FlickrImage(id: "52191358602", secret: "5586d30a64", server: "65535")
        static let singleImagePath = "\(singleImageModel.server)/\(singleImageModel.id)_\(singleImageModel.secret)"
    }
}

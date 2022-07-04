//
//  ApiServiceTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

final class ApiServiceTests: XCTestCase {
    func testGetPicturesSuccess() {
        // given
        let networkLayerMock = NetworkLayerMock()
        let api = FlickrApiService(with: networkLayerMock)
        networkLayerMock.resultStub = .success(TestData.jsonData)
        
        // when
        api.getPictures(searchText: TestData.searchText, page: TestData.page) { result in
            switch result {
            case let .success(dto):
                XCTAssert(dto == TestData.responseDto.photos, "The dto model should not be changed")
            case .failure:
                XCTAssert(false, "The failure statement should not be called")
            }
        }
        
        // then
        XCTAssert(networkLayerMock.getWasCalled == 1, "The get mathod should be called once")
        XCTAssert(networkLayerMock.passedUrl == TestData.searchPicturesUrl, "The urls should match")
    }
    
    func testGetPictureFailure() {
        // given
        let networkLayerMock = NetworkLayerMock()
        let api = FlickrApiService(with: networkLayerMock)
        networkLayerMock.resultStub = .failure(TestData.error)
        
        // when
        api.getPictures(searchText: TestData.searchText, page: TestData.page) { result in
            switch result {
            case .success:
                XCTAssert(false, "The success statement should not be called")
            case let .failure(error):
                XCTAssert(error as NSError == TestData.error, "The error should not be changed")
            }
        }
        
        // then
        XCTAssert(networkLayerMock.getWasCalled == 1, "The get mathod should be called once")
        XCTAssert(networkLayerMock.passedUrl == TestData.searchPicturesUrl, "The urls should match")
    }
    
    func testDownloadPictureSuccess() {
        // given
        let networkLayerMock = NetworkLayerMock()
        let api = FlickrApiService(with: networkLayerMock)
        networkLayerMock.resultStub = .success(TestData.imageData)
        
        // when
        api.downloadPicture(for: TestData.pictureId) { result in
            switch result {
            case let .success(image):
                XCTAssert(image == TestData.image, "The image should not be changed")
            case .failure:
                XCTAssert(false, "The failure statement should not be called")
            }
        }
        
        
        // then
        XCTAssert(networkLayerMock.getWasCalled == 1, "The get mathod should be called once")
        XCTAssert(networkLayerMock.passedUrl == TestData.pictureUrl, "The url should not be changed")
    }
    
    func testDownloadPictureFailure() {
        // given
        let networkLayerMock = NetworkLayerMock()
        let api = FlickrApiService(with: networkLayerMock)
        networkLayerMock.resultStub = .failure(TestData.error)
        
        // when
        api.downloadPicture(for: TestData.pictureId) { result in
            switch result {
            case .success:
                XCTAssert(false, "The success statement should not be called")
            case let .failure(error):
                XCTAssert(error as NSError == TestData.error, "The error should not be changed")
            }
        }
        
        // then
        XCTAssert(networkLayerMock.getWasCalled == 1, "The get mathod should be called once")
        XCTAssert(networkLayerMock.passedUrl == TestData.pictureUrl, "The url should not be changed")
    }

    func testRecentUrl() {
        // given
        let networkLayerMock = NetworkLayerMock()
        let api = FlickrApiService(with: networkLayerMock)
        
        // when
        api.getPictures(searchText: TestData.searchText, page: TestData.page) { result in }
        
        // then
        XCTAssert(networkLayerMock.passedUrl == TestData.searchPicturesUrl, "The urls should match")
    }
    
    func testSearchUrl() {
        // given
        let networkLayerMock = NetworkLayerMock()
        let api = FlickrApiService(with: networkLayerMock)
        
        // when
        api.getPictures(searchText: "", page: TestData.page) { result in }
        
        // then
        XCTAssert(networkLayerMock.passedUrl == TestData.recentPicturesUrl, "The urls should match")
    }
}

private extension ApiServiceTests {
    enum TestData {
        static let pictureUrl = "http://farm1.static.flickr.com/\(pictureId).png"
        static let pictureId = "identifier"
        static let imageData = Data()
        static let image = UIImage(data: imageData)
        static let jsonData = try! Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: ApiServiceTests())).path(forResource: "TestJson", ofType: "json")!))
        static let responseDto = try! JSONDecoder().decode(FlickrImagesSearchResponseDTO.self, from: jsonData)
        static let error = NSError(domain: "Some domain", code: -1)
        static let searchText = "Some search text"
        static let page = Page(pageNumber: 150)
        static let searchPicturesUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9480a18b30ba78893ebd8f25feaabf17&format=json&nojsoncallback=1&text=\(searchText)&page=\(page.pageNumber)&per_page=\(page.itemsCount)"
        static let recentPicturesUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=9480a18b30ba78893ebd8f25feaabf17&format=json&nojsoncallback=1&text=\("")&page=\(page.pageNumber)&per_page=\(page.itemsCount)"
    }
}

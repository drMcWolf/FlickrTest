//
//  ImagesListInteractorTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

final class ImagesListInteractorTests: XCTestCase {
    func testObtainImagesListSuccess() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        serviceMock.resultStub = .success(TestData.models)
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.obtainImagesList(request: TestData.emptySearchTextRequest)
        
        // then
        
        XCTAssert(storageMock.saveWasCalled == 0, "The save method should not be called on the empty search text")
        XCTAssert(storageMock.images == TestData.models, "The images array should be the same as passed from the service")
        XCTAssert(storageMock.page == TestData.firstPage, "The page should be the first on the empty search text")
        XCTAssert(storageMock.searchText == "", "The search text in storage should be empty")
        XCTAssert(presenterMock.presentResponseListWasCalled == 2, "The present method should be called twice")
        XCTAssert(presenterMock.presentLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(presenterMock.hideLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(serviceMock.obtainWasCalled == 1, "The method should be called once")
        XCTAssert(serviceMock.passedPage == TestData.firstPage, "The page should be the first on the empty search text")
        XCTAssert(serviceMock.passedSearchText == "", "The search text passed to service should be empty")
    }
    
    func testObtainImagesListFailure() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        serviceMock.resultStub = .failure(TestData.error)
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.obtainImagesList(request: TestData.emptySearchTextRequest)
        
        // then
        
        XCTAssert(storageMock.saveWasCalled == 0, "The save method should not be called on the empty search text")
        XCTAssert(storageMock.images.isEmpty, "The images array should be empty")
        XCTAssert(storageMock.page == TestData.firstPage, "The page should be the first on the empty search text")
        XCTAssert(storageMock.searchText == "", "The search text in storage should be empty")
        XCTAssert(presenterMock.presentResponseListWasCalled == 1, "The present method should be called once")
        XCTAssert(presenterMock.presentLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(presenterMock.hideLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(serviceMock.obtainWasCalled == 1, "The method should be called once")
        XCTAssert(serviceMock.passedPage == TestData.firstPage, "The page should be the first on the empty search text")
        XCTAssert(serviceMock.passedSearchText == "", "The search text passed to service should be empty")
        XCTAssert(outputMock.handleWasCalled == 1, "The output handle method should be called once")
        XCTAssert(outputMock.passedOutput == .errorAlert(TestData.error.localizedDescription), "The output case should be .showError")
    }
    
    func testStartLoadingImageSuccess() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        storageMock.images = TestData.models
        storageMock.page = .init(pageNumber: 1)
        serviceMock.downloadResultStub = .success(UIImage())
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.startLoadingImage(for: 1)
        
        // then
        let expectation = expectation(description: "testOsagoRegistrationViewControllerEmpty")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    
        XCTAssert(storageMock.page.pageNumber == 1, "The number of page should not be incremented")
        XCTAssert(storageMock.imagesGetWasCalled == 2, "The array getter should be calledd twice")
        XCTAssert(serviceMock.dowloadWasCalled == 1, "The download method should be called once")
        XCTAssert(presenterMock.presentResponseImageWasCalled == 1, "The present method should be called once")
        XCTAssert(presenterMock.passedResponseImage == .init(index: 1, imageModel: TestData.models[1]), "The image models should match")
        XCTAssertNotNil(storageMock.images[1].image, "The image should not be nil")
    }
    
    func testStartLoadingImageFailure() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        storageMock.images = TestData.models
        storageMock.page = .init(pageNumber: 1)
        serviceMock.downloadResultStub = .failure(TestData.error)
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.startLoadingImage(for: 1)
        
        // then
        let expectation = expectation(description: "testOsagoRegistrationViewControllerEmpty")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssert(storageMock.page.pageNumber == 1, "The number of page should not be incremented")
        XCTAssert(storageMock.imagesGetWasCalled == 2, "The array getter should be calledd twice")
        XCTAssert(serviceMock.dowloadWasCalled == 1, "The download method should be called once")
        XCTAssert(presenterMock.presentResponseImageWasCalled == 1, "The present method should be called once")
        XCTAssert(presenterMock.passedResponseImage == .init(index: 1, imageModel: TestData.models[1]), "The image models should match")
        XCTAssertNil(storageMock.images[1].image, "The image should be nil")
    }
    
    func testStartLoadingLastImage() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        storageMock.images = TestData.models
        storageMock.page = .init(pageNumber: 1)
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.startLoadingImage(for: 4)
        
        // then
        let expectation = expectation(description: "testOsagoRegistrationViewControllerEmpty")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    
        XCTAssert(storageMock.page.pageNumber == 2, "The number of page should be incremented")
        XCTAssert(serviceMock.obtainWasCalled == 1, "The method should be called once")
    }
    
    func testStopLoadinImage() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        storageMock.images = TestData.models
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.stopLoadinImage(for: 1)
        
        // then
        XCTAssert(storageMock.imagesGetWasCalled == 2, "The getter should be call twice")
    }
    
    func testStopLoadinImageWhenEmpty() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        storageMock.images = []
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.stopLoadinImage(for: 1)
        
        // then
        XCTAssert(storageMock.imagesGetWasCalled == 1, "The getter should be call twice")
    }
    
    func testOnSearchHistory() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when
        interactor.onSearchHistory()
        
        // then
        
        XCTAssert(outputMock.handleWasCalled == 1, "The method should be called once")
        XCTAssert(outputMock.passedOutput == .searchHistory(storageMock), "The case should be .searchHistory")
    }

    func testApplySearchItem() {
        // given
        let storageMock = ImagesListStorageMock()
        let presenterMock = ImagesListPresenterMock()
        let serviceMock = ImagesListServiceMock()
        let outputMock = ImagesListOutputMock()
        
        let interactor = ImagesListInteractor(
            with: storageMock,
            presenter: presenterMock,
            service: serviceMock,
            output: outputMock
        )
        
        // when

        interactor.apply(searchItem: TestData.searchItem)
        
        // then
        
        XCTAssert(storageMock.saveWasCalled == 1, "The save method should be called")
        XCTAssert(storageMock.page == TestData.firstPage, "The page should be the first on the empty search text")
        XCTAssert(storageMock.searchText == TestData.searchItem.text, "The search text in storage should be the same")
        XCTAssert(presenterMock.presentLoadingWasCalled == 1, "The method should be called once")
        XCTAssert(serviceMock.obtainWasCalled == 1, "The method should be called once")
        XCTAssert(serviceMock.passedPage == TestData.firstPage, "The page should be the first on the empty search text")
        XCTAssert(serviceMock.passedSearchText == TestData.searchItem.text, "The search text passed to service should be empty")
    }
}

private extension ImagesListInteractorTests {
    enum TestData {
        static let error = NSError(domain: "Some domain", code: -1)
        static let emptySearchTextRequest: ImagesList.Request = .init(searchText: "")
        static let firstPage: Page = .init(pageNumber: 1)
        static let searchDto = FlickrImageSearchDTO(photo: [
            .init(id: "52191358602", secret: "5586d30a64", server: "65535"),
            .init(id: "52191359307", secret: "3d81e448b8", server: "65535"),
            .init(id: "52191359782", secret: "469dfdd762", server: "65535"),
            .init(id: "52191359877", secret: "649ffb50b4", server: "65535"),
            .init(id: "52192368846", secret: "1b55023593", server: "65535")
        ])
        static let models: [FlickrImage] = searchDto.photo.map { FlickrImage(id: $0.id, secret: $0.secret, server: $0.server) }
        static let searchItem = SearchItemMock(date: Date(), text: "Some text")
    }
}

//
//  ImagesListPresenterTests.swift
//  FlickrAppTests
//
//  Created by Ivan Makarov on 04.07.2022.
//

import XCTest
@testable import FlickrApp

class ImagesListPresenterTests: XCTestCase {
    func testPresentListResponse() {
        // given
        let viewControllerMock = ImageListViewControllerMock()
        let presenter = ImagesListPresenter()
        presenter.viewController = viewControllerMock
        
        // when
        presenter.present(response: TestData.listResponse)
        
        // then
        XCTAssert(viewControllerMock.displayListViewModelWasCalled == 1, "The metod should be called once")
        XCTAssert(viewControllerMock.passedListViewModel == TestData.listViewModel, "The viewmodels should match")
    }
    
    func testPresentImageResponse() {
        // given
        let viewControllerMock = ImageListViewControllerMock()
        let presenter = ImagesListPresenter()
        presenter.viewController = viewControllerMock
        
        // when
        presenter.present(response: TestData.imageResponse)
        
        // then
        XCTAssert(viewControllerMock.displayImageViewModelWasCalled == 1, "The metod should be called once")
        XCTAssert(viewControllerMock.passedImageViewModel == TestData.imageViewModel, "The viewmodels should match")
    }
    
    func testPresentLoading() {
        // given
        let viewControllerMock = ImageListViewControllerMock()
        let presenter = ImagesListPresenter()
        presenter.viewController = viewControllerMock
        
        // when
        presenter.presentLoading()
        
        // then
        XCTAssert(viewControllerMock.displayLoadingWasCalled == 1, "The metod should be called once")
    }
    
    func testHideLoading() {
        // given
        let viewControllerMock = ImageListViewControllerMock()
        let presenter = ImagesListPresenter()
        presenter.viewController = viewControllerMock
        
        // when
        presenter.hideLoading()
        
        // then
        XCTAssert(viewControllerMock.dismissLoadingWasCalled == 1, "The metod should be called once")
    }
}

private extension ImagesListPresenterTests {
    enum TestData {
        static let imageViewModel = ImageCell.ViewModel(image: UIImage(named: "defaultPicture"))
        static let imageResponse = ImagesList.Response.Image(index: 0, imageModel: models[0])
        static let listViewModel = ImagesListView.ViewModel(searchText: listResponse.searchText, images: models.map { _ in .init(image: UIImage(named: "defaultPicture")) })
        static let listResponse = ImagesList.Response.List(searchText: "Some text", images: models)
        static let searchDto = FlickrImageSearchDTO(photo: [
            .init(id: "52191358602", secret: "5586d30a64", server: "65535"),
            .init(id: "52191359307", secret: "3d81e448b8", server: "65535"),
            .init(id: "52191359782", secret: "469dfdd762", server: "65535"),
            .init(id: "52191359877", secret: "649ffb50b4", server: "65535"),
            .init(id: "52192368846", secret: "1b55023593", server: "65535")
        ])
        static let models: [FlickrImage] = searchDto.photo.map { FlickrImage(id: $0.id, secret: $0.secret, server: $0.server) }
    }
}

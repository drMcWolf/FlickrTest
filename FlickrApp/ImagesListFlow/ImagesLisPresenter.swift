//
//  ImagesListPresenter.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation

protocol ImagesListPresentationLogic {
    func present(response: ImagesList.Response.List)
    func present(response: ImagesList.Response.Image)
    func presentLoading()
    func hideLoading()
}

final class ImagesListPresenter {
    weak var viewController: ImagesListDisplayLogic?
}

extension ImagesListPresenter: ImagesListPresentationLogic {
    func present(response: ImagesList.Response.List) {
        viewController?.display(
            viewModel: .init(
                searchText: response.searchText, images: response.images.map { .init(image: $0.image) }
            )
        )
    }
    
    func present(response: ImagesList.Response.Image) {
        viewController?.display(viewModel: .init(image: response.imageModel.image), for: response.index)
    }
    
    func presentLoading() {
        viewController?.dismissLoading()
    }
    
    func hideLoading() {
        viewController?.dismissLoading()
    }
}

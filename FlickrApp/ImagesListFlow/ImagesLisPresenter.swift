//
//  ImagesListPresenter.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import UIKit

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
                searchText: response.searchText, images: response.images.map { .init(image: $0.image ?? UIImage(named: "defaultPicture")) }
            )
        )
    }
    
    func present(response: ImagesList.Response.Image) {
        viewController?.display(viewModel: .init(image: response.imageModel.image ?? UIImage(named: "defaultPicture")), for: response.index)
    }
    
    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func hideLoading() {
        viewController?.dismissLoading()
    }
}

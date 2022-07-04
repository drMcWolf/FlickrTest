//
//  ImagesListInteractor.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation

protocol ImagesListInput {
    func apply(searchItem: SearchItemProtocol)
}

protocol ImagesListOutput {
    func handle(output: ImagesList.Output)
}

protocol ImagesListBusinessLogic {
    func obtainImagesList(request: ImagesList.Request)
    func startLoadingImage(for index: Int)
    func stopLoadinImage(for index: Int)
    func onSearchHistory()
}

final class ImagesListInteractor {
    private let storage: ImagesListStorageProtocol
    private let presenter: ImagesListPresentationLogic
    private let service: ImagesListServiceProtocol
    private let output: ImagesListOutput
    private var downloadingOperationQueue = OperationQueue()
    
    init(
        with storage: ImagesListStorageProtocol,
        presenter: ImagesListPresentationLogic,
        service: ImagesListServiceProtocol,
        output: ImagesListOutput)
    {
        self.storage = storage
        self.presenter = presenter
        self.service = service
        self.output = output
    }
}

private extension ImagesListInteractor {
    func fetchImages(with searchText: String, for page: Page) {
        presenter.presentLoading()
        service.obtainImagesList(searchText: searchText, page: page) { result in
            self.presenter.hideLoading()
            switch result {
            case let .success(models):
                self.storage.images.append(contentsOf: models)
                self.presenter.present(response: .init(searchText: self.storage.searchText, images: self.storage.images))
            case let .failure(error):
                self.output.handle(output: .errorAlert(error.localizedDescription))
            }
        }
    }
}

extension ImagesListInteractor: ImagesListBusinessLogic {
    func obtainImagesList(request: ImagesList.Request) {
        if !request.searchText.isEmpty {
            storage.save(searchText: request.searchText)
        }
        storage.images.removeAll()
        storage.page = Page()
        storage.searchText = request.searchText
        presenter.present(response: .init(searchText: storage.searchText, images: storage.images))

        fetchImages(with: storage.searchText, for: storage.page)
    }
    
    func startLoadingImage(for index: Int) {
        let image = storage.images[index]
        guard image.image == nil else {
            presenter.present(response: .init(index: index, imageModel: image))
            return
        }
        let operation = ImageDownloadingOperation(with: image, service: service)
        operation.completionBlock = {
            OperationQueue.main.addOperation {
                self.presenter.present(response: .init(index: index, imageModel: image))
            }
        }
        downloadingOperationQueue.addOperation(operation)
        
        if index == storage.images.count - 1 {
            storage.page.pageNumber += 1
            fetchImages(with: storage.searchText, for: storage.page)
        }
    }
    
    func stopLoadinImage(for index: Int) {
        if storage.images.isEmpty { return }
        let image = storage.images[index]
        let operations = downloadingOperationQueue.operations as? [ImageDownloadingOperation]
        if let operation = operations?.first(where: { $0.imageModel == image }) {
            operation.cancel()
        }
    }
    
    func onSearchHistory() {
        output.handle(output: .searchHistory(storage))
    }
}

extension ImagesListInteractor: ImagesListInput {
    func apply(searchItem: SearchItemProtocol) {
        obtainImagesList(request: .init(searchText: searchItem.text ?? ""))
    }
}

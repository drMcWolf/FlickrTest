//
//  ImagesListAssembly.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation

protocol ImagesListAssemblyProtocol {
    func assembly(output: ImagesListOutput) -> Module<ImagesListInput>
}

final class ImagesListAssembly {  }

extension ImagesListAssembly: ImagesListAssemblyProtocol {
    func assembly(output: ImagesListOutput) -> Module<ImagesListInput> {
        let presenter = ImagesListPresenter()
        
        let networkLayer = NetworkLayer()
        let apiService = FlickrApiService(with: networkLayer)
        let service = ImagesListService(with: apiService)
        let storageManager = StorageManager()
        let storage = ImagesListStorage(storageManager: storageManager)
        
        let interactor = ImagesListInteractor(with: storage, presenter: presenter, service: service, output: output)
        let controller = ImagesListViewController(interactor: interactor)
        
        presenter.viewController = controller
        return Module(input: interactor, view: controller)
    }
}


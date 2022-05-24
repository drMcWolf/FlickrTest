//
//  SearchHistoryAssembly.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import Foundation

protocol SearchHistoryAssemblyProtocol {
    func assembly(storage: ImagesListStorageProtocol, output: SearchHistoryOutput) -> SearchHistoryViewController
}

final class SearchHistoryAssembly {
    
}

extension SearchHistoryAssembly: SearchHistoryAssemblyProtocol {
    func assembly(storage: ImagesListStorageProtocol, output: SearchHistoryOutput) -> SearchHistoryViewController {
        let presenter = SearchHistoryPresenter()
        let interactor = SearchHistoryInteractor(with: presenter, storage: storage, output: output)
        let controller = SearchHistoryViewController(interactor: interactor)
        
        presenter.viewController = controller
        return controller
    }
}

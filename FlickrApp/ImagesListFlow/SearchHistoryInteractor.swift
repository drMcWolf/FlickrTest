//
//  SearchHistoryInteractor.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import Foundation

protocol SearchHistoryOutput {
    func handle(output: SearchHistory.Output)
}

protocol SearchHistoryBusinessLogic {
    func obtainInitialState(request: SearchHistory.Request)
    func selectItem(at index: Int)
}

final class SearchHistoryInteractor {
    private let presenter: SearchHistoryPresentationLogic
    private let storage: ImagesListStorageProtocol
    private let output: SearchHistoryOutput
    
    init(with presenter: SearchHistoryPresentationLogic, storage: ImagesListStorageProtocol, output: SearchHistoryOutput) {
        self.presenter = presenter
        self.storage = storage
        self.output = output
    }
}

extension SearchHistoryInteractor: SearchHistoryBusinessLogic {
    func obtainInitialState(request: SearchHistory.Request) {
        let history = storage.fetchSearchHistory()
        presenter.present(response: .init(items: history))
    }
    
    func selectItem(at index: Int) {
        let history = storage.fetchSearchHistory()
        let item = history[index]
        output.handle(output: .select(item))
    }
}

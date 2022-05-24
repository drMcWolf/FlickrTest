//
//  SearchHistoryPresenter.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import Foundation

protocol SearchHistoryPresentationLogic {
    func present(response: SearchHistory.Response)
}

final class SearchHistoryPresenter {
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter
    }()
    weak var viewController: SearchHistoryDisplayLogic?
}

extension SearchHistoryPresenter: SearchHistoryPresentationLogic {
    func present(response: SearchHistory.Response) {
        viewController?.display(
            viewModel: .init(
                items: response.items.map { .init(title: $0.text ?? "", details: formatter.string(from: $0.date!)) }
            )
        )
    }
}

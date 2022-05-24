//
//  SearchHistoryViewController.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import UIKit

protocol SearchHistoryDisplayLogic: AnyObject {
    func display(viewModel: SearchHistoryView.ViewModel)
}

final class SearchHistoryViewController: UIViewController {
    private let interactor: SearchHistoryBusinessLogic
    private lazy var searchHistoryView = SearchHistoryView(with: self)
    
    override func loadView() {
        view = searchHistoryView
    }
    
    init(interactor: SearchHistoryBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        interactor.obtainInitialState(request: .init())
    }
}

extension SearchHistoryViewController: SearchHistoryDisplayLogic {
    func display(viewModel: SearchHistoryView.ViewModel) {
        searchHistoryView.configure(with: viewModel)
    }
}

extension SearchHistoryViewController: SearchHistoryViewDelegate {
    func selectItem(at index: Int) {
        interactor.selectItem(at: index)
    }
}

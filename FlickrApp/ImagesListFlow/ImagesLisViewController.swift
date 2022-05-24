//
//  MainViewController.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import UIKit

protocol ImagesListDisplayLogic: AnyObject {
    func display(viewModel: ImagesListView.ViewModel)
    func display(viewModel: ImageCell.ViewModel, for index: Int)
    func displayLoading()
    func dismissLoading()
}

class ImagesListViewController: UIViewController {
    private let interactor: ImagesListBusinessLogic
    private lazy var imagesListView = ImagesListView(with: self)
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()

    override func loadView() {
        view = imagesListView
    }
    
    init(interactor: ImagesListBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.obtainImagesList(request: .init(searchText: ""))
        edgesForExtendedLayout = []
        title = "Search"
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(historyButtonPressed))
        
        navigationItem.rightBarButtonItem = barButtonItem
        addSubviews()
        makeConstraints()
    }
}

private extension ImagesListViewController {
    @objc func historyButtonPressed() {
        interactor.onSearchHistory()
    }
    
    func addSubviews() {
        view.addSubview(activityIndicator)
    }
    
    func makeConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension ImagesListViewController: ImagesListDisplayLogic {
    func display(viewModel: ImagesListView.ViewModel) {
        imagesListView.configure(with: viewModel)
    }
    
    func display(viewModel: ImageCell.ViewModel, for index: Int) {
        imagesListView.configure(with: viewModel, at: index)
    }
    
    func displayLoading() {
        activityIndicator.startAnimating()
    }
    
    func dismissLoading() {
        activityIndicator.stopAnimating()
    }
}

extension ImagesListViewController: ImagesListViewDelegate {
    func search(with text: String) {
        interactor.obtainImagesList(request: .init(searchText: text))
    }
    
    func willDisplayItem(at index: Int) {
        interactor.startLoadingImage(for: index)
    }
    
    func didDisplayItem(at index: Int) {
        interactor.stopLoadinImage(for: index)
    }
}

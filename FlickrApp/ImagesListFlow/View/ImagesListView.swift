//
//  ImagesListView.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import UIKit

protocol ImagesListViewDelegate: AnyObject {
    func search(with text: String)
    func willDisplayItem(at index: Int)
    func didDisplayItem(at index: Int)
}

final class ImagesListView: UIView {
    private struct Constants {
        static let identifier = String(describing: ImageCell.self)
        static let collectionViewInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        static let collectionViewInterItemSpacing: CGFloat = 10
        static let searchBarPlaceholder = "Search..."
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = Constants.searchBarPlaceholder
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    private weak var delegate: ImagesListViewDelegate?
    private var viewModel: ViewModel?
    
    init(with delegate: ImagesListViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImagesListView {
    func addSubviews() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    func makeConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension ImagesListView {
    func configure(with viewModel: ImageCell.ViewModel, at index: Int) {
        self.viewModel?.images[index] = viewModel
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}

extension ImagesListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        if let cellViewModel = viewModel?.images[indexPath.row] {
            cell.configure(with: cellViewModel)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ImageCell)?.starLoading()
        delegate?.willDisplayItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ImageCell)?.stopLoading()
        delegate?.didDisplayItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (frame.size.width - 30) / 2

        return CGSize(width: side, height: side)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.collectionViewInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.collectionViewInsets
    }
}

extension ImagesListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        delegate?.search(with: searchBar.text ?? "")
    }
}

extension ImagesListView: Configurable {
    struct ViewModel: Equatable {
        let searchText: String
        var images: [ImageCell.ViewModel]
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        self.searchBar.text = viewModel.searchText
        collectionView.reloadData()
    }
}

//
//  ImageCell.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    private lazy var imageView = UIImageView()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private var viewModel: ViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func starLoading() {
        if viewModel?.image == nil {
            activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

private extension ImageCell {
    private func commonInit() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(imageView)
        addSubview(activityIndicator)
    }

    private func makeConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}


extension ImageCell: Configurable {
    struct ViewModel: Equatable {
        let image: UIImage?
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        imageView.image = viewModel.image
    }
}

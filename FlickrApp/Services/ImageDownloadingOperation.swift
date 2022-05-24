//
//  ImageDownloadingOperation.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import Foundation

final class ImageDownloadingOperation: AsyncOperation {
    private(set) var imageModel: FlickrImage
    private let service: ImagesListServiceProtocol
    
    init(with imageModel: FlickrImage, service: ImagesListServiceProtocol) {
        self.imageModel = imageModel
        self.service = service
    }
    
    override func main() {
        service.download(imageModel: imageModel) {[weak self] result in
            self?.markFinished()
            switch result {
            case let .success(image):
                self?.imageModel.image = image
                self?.completionBlock?()
            case .failure: break
            }
        }
    }
}

//
//  ImagesListService.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation
import UIKit

protocol ImagesListServiceProtocol {
    func obtainImagesList(searchText: String, page: Page, completion: @escaping (Result<[FlickrImage], Error>) -> Void)
    func download(imageModel: FlickrImage, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImagesListService {
    private let apiService: ApiServiceProtocol
    
    init(with apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
}

extension ImagesListService: ImagesListServiceProtocol {
    func obtainImagesList(searchText: String, page: Page, completion: @escaping (Result<[FlickrImage], Error>) -> Void) {
        apiService.getPictures(searchText: searchText, page: page) { result in
            switch result {
            case let .success(dto):
                let models = dto.photo.map { FlickrImage(id: $0.id, secret: $0.secret, server: $0.server) }
                completion(.success(models))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func download(imageModel: FlickrImage, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let url = "\(imageModel.server)/\(imageModel.id)_\(imageModel.secret)"
        apiService.downloadPicture(for: url, completion: completion)
    }
}

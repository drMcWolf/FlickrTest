//
//  ImagesListStorage.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation

protocol ImagesListStorageProtocol: AnyObject {
    var page: Page { get set}
    var searchText: String { get set }
    var images: [FlickrImage] { get set }
    func save(searchText: String)
    func fetchSearchHistory() -> [SearchItem]
}

final class ImagesListStorage: ImagesListStorageProtocol {
    private var storageManager: StorageManagerProtocol
    var page: Page = .init()
    var searchText: String = ""
    var images: [FlickrImage] = []
    
    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }
    
    func save(searchText: String) {
        storageManager.saveSearch(text: searchText)
    }
    
    func fetchSearchHistory() -> [SearchItem] {
        return storageManager.fetch()
    }
}

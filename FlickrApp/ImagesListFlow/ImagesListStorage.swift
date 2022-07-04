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
    func fetchSearchHistory() -> [SearchItemProtocol]
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
        let newItem = storageManager.insert(new: SearchItem.self)
        newItem?.date = Date()
        newItem?.text = searchText
    }
    
    func fetchSearchHistory() -> [SearchItemProtocol] {
        return storageManager.find(type: SearchItem.self, sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
    }
}

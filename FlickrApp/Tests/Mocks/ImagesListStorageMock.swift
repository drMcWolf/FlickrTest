//
//  ImagesListStorageMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class ImagesListStorageMock: ImagesListStorageProtocol {
    private var _page: Page = .init(pageNumber: 0)
    private var _searchText: String = ""
    private var _images: [FlickrImage] = []
    
    var pageSetWasCalled: Int = 0
    var pageGetWasCalled: Int = 0
    
    var page: Page {
        get {
            pageGetWasCalled += 1
            return _page
        }
        
        set {
            pageSetWasCalled += 1
            _page = newValue
        }
    }
    
    var searchTextSetWasCalled: Int = 0
    var searchTextGetWasCalled: Int = 0
    
    var searchText: String {
        get {
            searchTextGetWasCalled += 1
            return _searchText
        }
        
        set {
            searchTextSetWasCalled += 1
            _searchText = newValue
        }
    }
    
    var imagesSetWasCalled: Int = 0
    var imagesGetWasCalled: Int = 0
    
    var images: [FlickrImage] {
        get {
            imagesGetWasCalled += 1
            return _images
        }
        
        set {
            imagesSetWasCalled += 1
            _images = newValue
        }
    }
    
    var saveWasCalled: Int = 0
    var passedSearchText: String = ""
    
    func save(searchText: String) {
        self.searchText = searchText
        saveWasCalled += 1
    }
    
    var fetchSearchHistoryWasCalled: Int = 0
    var fetchResultStub: [SearchItemProtocol] = []
    func fetchSearchHistory() -> [SearchItemProtocol] {
        fetchSearchHistoryWasCalled += 1
        return fetchResultStub
    }
    
    
}

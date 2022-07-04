//
//  SearchItemProtocol.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation

protocol SearchItemProtocol {
    var date: Date? { get set }
    var text: String? { get set }
}

extension SearchItem: SearchItemProtocol {}

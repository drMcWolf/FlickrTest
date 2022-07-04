//
//  FlickrImage.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import UIKit

class FlickrImage {
    let id: String
    let secret: String
    let server: String
    var image: UIImage?
    
    init(id: String, secret: String, server: String) {
        self.id = id
        self.secret = secret
        self.server = server
    }
}

extension FlickrImage: Equatable {
    static func == (lhs: FlickrImage, rhs: FlickrImage) -> Bool {
        lhs.id == rhs.id && lhs.server == rhs.server && lhs.secret == rhs.secret && lhs.image == rhs.image
    }
}

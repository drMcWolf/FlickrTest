//
//  FlickrImageDTO.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation
import UIKit

struct FlickrImagesSearchResponseDTO: Decodable {
    let photos: FlickrImageSearchDTO
}

struct FlickrImageSearchDTO: Decodable {
    let photo: [FlickrImageDTO]
}

struct FlickrImageDTO: Decodable {
    let id: String
    let secret: String
    let server: String
}

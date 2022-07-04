//
//  FlickrImageDTO.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import Foundation
import UIKit

public struct FlickrImagesSearchResponseDTO: Decodable, Equatable {
    let photos: FlickrImageSearchDTO
}

public struct FlickrImageSearchDTO: Decodable, Equatable {
    let photo: [FlickrImageDTO]
}

public struct FlickrImageDTO: Decodable, Equatable {
    let id: String
    let secret: String
    let server: String
}

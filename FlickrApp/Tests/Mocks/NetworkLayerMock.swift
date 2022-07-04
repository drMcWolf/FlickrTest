//
//  NetworkLayerMock.swift
//  CitySearchTests
//
//  Created by Ivan Makarov on 21.06.2022.
//

import Foundation
@testable import FlickrApp

final class NetworkLayerMock: NetworkLayerProtocol {
    var passedUrl: String = ""
    var getWasCalled = 0
    var resultStub: Result<Data, Error>?
    
    func get(url: String, parameters: [String : Any]?, completion: @escaping (Result<Data, Error>) -> Void) {
        getWasCalled += 1
        passedUrl = url
        if let resultStub = resultStub {
            completion(resultStub)
        }
    }
}

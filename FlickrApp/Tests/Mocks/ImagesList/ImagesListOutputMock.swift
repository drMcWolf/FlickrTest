//
//  ImagesListOutputMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class ImagesListOutputMock: ImagesListOutput {
    var handleWasCalled: Int = 0
    var passedOutput: ImagesList.Output!
    
    func handle(output: ImagesList.Output) {
        passedOutput = output
        handleWasCalled += 1
    }
}

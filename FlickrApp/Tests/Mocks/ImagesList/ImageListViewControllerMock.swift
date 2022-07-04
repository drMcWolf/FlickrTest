//
//  ImageListViewControllerMock.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 04.07.2022.
//

import Foundation
@testable import FlickrApp

final class ImageListViewControllerMock: ImagesListDisplayLogic {
    var displayListViewModelWasCalled: Int = 0
    var passedListViewModel: ImagesListView.ViewModel?
        
    func display(viewModel: ImagesListView.ViewModel) {
        passedListViewModel = viewModel
        displayListViewModelWasCalled += 1
    }
    
    var displayImageViewModelWasCalled: Int = 0
    var passedIndex: Int?
    var passedImageViewModel: ImageCell.ViewModel?
    
    func display(viewModel: ImageCell.ViewModel, for index: Int) {
        passedIndex = index
        passedImageViewModel = viewModel
        displayImageViewModelWasCalled += 1
    }
    
    var displayLoadingWasCalled: Int = 0
    
    func displayLoading() {
        displayLoadingWasCalled += 1
    }
    
    var dismissLoadingWasCalled: Int = 0
    
    func dismissLoading() {
        dismissLoadingWasCalled += 1
    }
}

//
//  Module.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import UIKit

final class Module<ModuleInputType> {
    public var input: ModuleInputType
    public var view: UIViewController

    public init(input: ModuleInputType, view: UIViewController) {
        self.input = input
        self.view = view
    }
}

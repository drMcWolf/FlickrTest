//
//  AppDelegate.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 23.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var coordinator: ApplicationFlowCoordinatorProtocol?
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        openInitialScreen()
        return true
    }
}

private extension AppDelegate {
    func openInitialScreen() {
        guard let window = window else { return }
        
        let imagesListAssembly = ImagesListAssembly()
        let historyAssembly = SearchHistoryAssembly()
        
        let navigationController = UINavigationController()
        
        coordinator = ApplicationFlowCoordinator(with: navigationController, imagesListAssembly: imagesListAssembly, historyAssembly: historyAssembly)
        coordinator?.openInitialScreen()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}

import Foundation
import UIKit

protocol ApplicationFlowCoordinatorProtocol {
    func openInitialScreen()
}

final class ApplicationFlowCoordinator {
    private let navigationController: UINavigationController
    private let imagesListAssembly: ImagesListAssemblyProtocol
    private let historyAssembly: SearchHistoryAssemblyProtocol
    private var imagesListInput: ImagesListInput?
    
    init(with navigationController: UINavigationController, imagesListAssembly: ImagesListAssemblyProtocol, historyAssembly: SearchHistoryAssemblyProtocol) {
        self.navigationController = navigationController
        self.imagesListAssembly = imagesListAssembly
        self.historyAssembly = historyAssembly
    }
}

extension ApplicationFlowCoordinator: ApplicationFlowCoordinatorProtocol {
    func openInitialScreen() {
        let module = imagesListAssembly.assembly(output: self)
        self.imagesListInput = module.input

        navigationController.view.backgroundColor = .white
        navigationController.viewControllers = [module.view]
    }
}

private extension ApplicationFlowCoordinator {
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(okAction)

        navigationController.present(alertController, animated: true)
    }
    
    func showSearchHistory(storage: ImagesListStorageProtocol) {
        let viewController = historyAssembly.assembly(storage: storage, output: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ApplicationFlowCoordinator: ImagesListOutput {
    func handle(output: ImagesList.Output) {
        switch output {
        case let .errorAlert(message):
            showErrorAlert(message: message)
        case let .searchHistory(storage):
            showSearchHistory(storage: storage)
        }
    }
}

extension ApplicationFlowCoordinator: SearchHistoryOutput {
    func handle(output: SearchHistory.Output) {
        switch output {
        case let .select(searchItem):
            imagesListInput?.apply(searchItem: searchItem)
            navigationController.popToRootViewController(animated: true)
        }
    }
}

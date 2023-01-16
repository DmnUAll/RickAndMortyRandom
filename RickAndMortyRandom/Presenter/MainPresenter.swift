import UIKit

// MARK: - MainPresenter
final class MainPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: MainController?
    private var networkManager = NetworkManager()

    init(viewController: MainController? = nil) {
        self.viewController = viewController
        networkManager.delegate = viewController
    }
}

// MARK: - Helpers
extension MainPresenter {

    func loadCharacter() {
        networkManager.performRequest()
    }
}

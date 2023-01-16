import UIKit

// MARK: - NavigationButtonsDelegate protocol
protocol NavigationButtonsDelegate: AnyObject {
    func infoTapped()
    func refreshTapped()
    func webTapped()
}

// MARK: - NavigationController
final class NavigationController: UINavigationController {

    // MARK: - Properties and Initializers
    weak var buttonsDelegate: NavigationButtonsDelegate?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension NavigationController {

    @objc private func infoButtonTapped() {
        buttonsDelegate?.infoTapped()
    }

    @objc private func refreshButtonTapped() {
        buttonsDelegate?.refreshTapped()
    }

    @objc private func webButtonTapped() {
        buttonsDelegate?.webTapped()
    }

    private func configureNavigationController() {
        navigationBar.tintColor = .ramrCream
        navigationBar.backgroundColor = .ramrGreenDark
        navigationBar.layer.borderColor = UIColor.ramrBrownDark.cgColor
        navigationBar.layer.borderWidth = 4
        navigationBar.layer.cornerRadius = 20
        navigationBar.clipsToBounds = true
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                         style: .plain,
                                         target: nil,
                                         action: #selector(infoButtonTapped))
        navigationBar.topItem?.leftBarButtonItem = infoButton
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"),
                                            style: .plain,
                                            target: nil,
                                            action: #selector(refreshButtonTapped))
        let webButton = UIBarButtonItem(image: UIImage(systemName: "globe"),
                                        style: .plain,
                                        target: nil,
                                        action: #selector(webButtonTapped))
        navigationBar.topItem?.rightBarButtonItems = [webButton, refreshButton]
    }
}

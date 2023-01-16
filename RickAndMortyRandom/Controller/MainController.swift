import UIKit

// MARK: - MainController
final class MainController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: MainPresenter?
    private lazy var mainView: MainView = {
        let view = MainView()
        return view
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ramrSalad
        presenter = MainPresenter(viewController: self)
        (navigationController as? NavigationController)?.buttonsDelegate = self
        view.addSubview(mainView)
        setupConstraints()
        showOrHideUI()
        presenter?.loadCharacter()
    }
}

// MARK: - Helpers
extension MainController {

    private func setupConstraints() {
        let constraints = [
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func showOrHideUI() {
        navigationController?.isNavigationBarHidden.toggle()
        mainView.imageView.isHidden.toggle()
        mainView.infoStackView.isHidden.toggle()
        if mainView.activityIndicator.isAnimating {
            mainView.activityIndicator.stopAnimating()
        } else {
            mainView.activityIndicator.startAnimating()
        }
    }

    private func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let gotItAction = UIAlertAction(title: "Got it!", style: .default)
        alertController.addAction(gotItAction)
        present(alertController, animated: true)
    }
}

// MARK: - NavigationButtonsDelegate
extension MainController: NavigationButtonsDelegate {
    func infoTapped() {
        showAlert(withTitle: "About Author", andMessage: "It was me! :)")
    }

    func refreshTapped() {
        showOrHideUI()
        presenter?.loadCharacter()
    }

    func webTapped() {
        let searchLink = "https://www.google.com/search?q=Rick%20and%20Morty%20"
        guard let characterName = mainView.nameLabel.text?.replacingOccurrences(of: " ", with: "%20"),
              let url = URL(string: "\(searchLink)\(characterName)") else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - NetworkManagerDelegate
extension MainController: NetworkManagerDelegate {

    func updateUI(with data: CharacterModel) {
        DispatchQueue.main.sync { [weak self] in
            guard let self = self else { return }
            self.mainView.imageView.image = UIImage(named: "noImage")
            self.mainView.imageView.load(url: data.imageURL)
            self.mainView.nameLabel.text = data.name
            self.mainView.statusLabel.text = "(Status: \(data.status))"
            self.mainView.speciesLabel.text = data.species == "" ? "Undefined" : data.species
            self.mainView.typeLabel.text = data.type == "" ? "Undefined" : data.type
            self.mainView.genderLabel.text = data.gender == "" ? "Undefined" : data.gender
            self.mainView.locationLabel.text = data.location.name == "" ? "Undefined" : data.location.name
            self.showOrHideUI()
        }
    }
}

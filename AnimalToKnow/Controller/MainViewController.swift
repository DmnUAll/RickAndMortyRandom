//
//  ViewController.swift
//  AnimalToKnow
//
//  Created by Илья Валито on 05.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var animalManager = AnimalManager()
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var latinNameLabel: UILabel!
    @IBOutlet private weak var activeTimeImageView: UIImageView!
    @IBOutlet private weak var maxLengthLabel: UILabel!
    @IBOutlet private weak var maxWeightLabel: UILabel!
    @IBOutlet private weak var lifespanLabel: UILabel!
    @IBOutlet private weak var habitatLabel: UILabel!
    @IBOutlet private weak var dietLabel: UILabel!
    @IBOutlet private weak var geographyLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet private var stackViews: [UIStackView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalManager.delegate = self
        
        showOrHideUI()
        animalManager.performRequest()
        
        // Some interface visual updates
        imageView.layer.cornerRadius = imageView.frame.size.width / 15
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.black.cgColor
        
        navigationController?.navigationBar.layer.cornerRadius = 20
        navigationController?.navigationBar.clipsToBounds = true
        //self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        for stackView in stackViews {
            stackView.layer.cornerRadius = stackView.frame.size.width / 15
            stackView.layer.borderWidth = 2.0
            stackView.layer.borderColor = UIColor.black.cgColor
        }
        
        infoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        infoStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func showOrHideUI() {
        
        imageView.isHidden.toggle()
        navigationController?.isNavigationBarHidden.toggle()
        
        for stackView in stackViews {
            stackView.isHidden.toggle()
        }
    }
    
    @IBAction private func refreshTapped(_ sender: UIBarButtonItem) {
        showOrHideUI()
        animalManager.performRequest()
        activityIndicator.startAnimating()
    }
}

extension MainViewController: AnimalManagerDelegate {
    func updateUI(with data: AnimalData) {
        DispatchQueue.main.async {
            self.nameLabel.text = data.name
            self.latinNameLabel.text = "(\(data.latinName), Type: \(data.type))"
            self.activeTimeImageView.image = UIImage(systemName: data.activeTime == "Nocturnal" ? "moon" : "sun.max")
            self.maxLengthLabel.text = String(format: "%.2f", (Double(data.minLength) ?? 0) * 0.3048) + " - " + String(format: "%.2f", (Double(data.maxLength) ?? 0) * 0.3048) + " m"
            self.maxWeightLabel.text = String(format: "%.2f", (Double(data.minWeight) ?? 0) / 2.2046) + " - " + String(format: "%.2f", (Double(data.maxWeight) ?? 0) / 2.2046) + " kg"
            self.lifespanLabel.text = "Lifespan: \(data.lifespan) yr(s)"
            self.habitatLabel.text = data.habitat
            self.dietLabel.text = data.diet
            self.geographyLabel.text = data.geography
            
            // Download an image by URL
            guard let image = data.image else {
                self.imageView.image = UIImage(named: "noImage")
                return
            }
            if let imageURL = URL(string: image) {
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            }
            self.activityIndicator.stopAnimating()
            self.showOrHideUI()
        }
    }
}

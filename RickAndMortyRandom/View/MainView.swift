import UIKit

// MARK: - MainView
final class MainView: UIView {

    // MARK: - Properties and Initializers
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.ramrBrownDark.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .ramrBrownDark
        return activityIndicator
    }()

    lazy var nameLabel: UILabel = {
        makeLabel(withText: "Name", font: UIFont(name: "Menlo Bold", size: 21))
    }()

    lazy var statusLabel: UILabel = {
        makeLabel(withText: "Status", font: UIFont(name: "Menlo Italic", size: 18))
    }()

    private lazy var nameAndStatusStackView: UIStackView = {
        let stackView = makeStackView(withAxis: .vertical, alignment: .center, andDistribution: .fillEqually)
        stackView.backgroundColor = .ramrGreenDark
        stackView.layer.cornerRadius = 25
        stackView.layer.borderWidth = 4
        stackView.layer.borderColor = UIColor.ramrBrownDark.cgColor
        stackView.clipsToBounds = true
        return stackView
    }()

    lazy var speciesLabel: UILabel = {
        makeLabel(withText: "Species", font: UIFont(name: "Menlo Regular", size: 18), andAlignment: .left)
    }()

    private lazy var speciesStackView: UIStackView = {
        makeStackView(alignment: .center, andDistribution: .fillEqually)
    }()

    lazy var typeLabel: UILabel = {
        makeLabel(withText: "Type", font: UIFont(name: "Menlo Regular", size: 18), andAlignment: .left)
    }()

    private lazy var typeStackView: UIStackView = {
        let stackView = makeStackView(alignment: .center, andDistribution: .fillEqually)
        stackView.layer.borderWidth = 4
        stackView.layer.borderColor = UIColor.ramrBrownDark.cgColor
        return stackView
    }()

    lazy var genderLabel: UILabel = {
        makeLabel(withText: "Gender", font: UIFont(name: "Menlo Regular", size: 18), andAlignment: .left)
    }()

    private lazy var genderStackView: UIStackView = {
        makeStackView(alignment: .center, andDistribution: .fillEqually)
    }()

    lazy var locationLabel: UILabel = {
        makeLabel(withText: "Location", font: UIFont(name: "Menlo Regular", size: 18), andAlignment: .left)
    }()

    private lazy var locationStackView: UIStackView = {
        let stackView = makeStackView(alignment: .center, andDistribution: .fillEqually)
        stackView.layer.borderWidth = 4
        stackView.layer.borderColor = UIColor.ramrBrownDark.cgColor
        return stackView
    }()

    lazy var infoStackView: UIStackView = {
        let stackView = makeStackView(withAxis: .vertical, andDistribution: .fillEqually)
        stackView.backgroundColor = .ramrGreenLight
        stackView.layer.cornerRadius = 25
        stackView.layer.borderWidth = 4
        stackView.layer.borderColor = UIColor.ramrBrownDark.cgColor
        stackView.clipsToBounds = true
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = makeStackView(withAxis: .vertical)
        stackView.toAutolayout()
        stackView.spacing = 12
        return stackView
    }()

    private lazy var linkTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "This app was made, using rickandmortyapi.com API")
        attributedString.addAttribute(.link, value: "https://rickandmortyapi.com",
                                      range: NSRange(location: 25, length: 19))
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.textAlignment = .center
        textView.font = UIFont(name: "Menlo Bold", size: 12)
        textView.textColor = .ramrGreenDark
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension MainView {

    private func addSubviews() {
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(activityIndicator)
        nameAndStatusStackView.addArrangedSubview(nameLabel)
        nameAndStatusStackView.addArrangedSubview(statusLabel)
        infoStackView.addArrangedSubview(nameAndStatusStackView)
        speciesStackView.addArrangedSubview(makeLabel(withText: "Species:"))
        speciesStackView.addArrangedSubview(speciesLabel)
        infoStackView.addArrangedSubview(speciesStackView)
        typeStackView.addArrangedSubview(makeLabel(withText: "Type:"))
        typeStackView.addArrangedSubview(typeLabel)
        infoStackView.addArrangedSubview(typeStackView)
        genderStackView.addArrangedSubview(makeLabel(withText: "Gender:"))
        genderStackView.addArrangedSubview(genderLabel)
        infoStackView.addArrangedSubview(genderStackView)
        locationStackView.addArrangedSubview(makeLabel(withText: "Location:"))
        locationStackView.addArrangedSubview(locationLabel)
        infoStackView.addArrangedSubview(locationStackView)
        mainStackView.addArrangedSubview(infoStackView)
        addSubview(linkTextView)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 24),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0/1.0),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            mainStackView.bottomAnchor.constraint(equalTo: linkTextView.topAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withText text: String,
                           font: UIFont? = UIFont(name: "Menlo Bold", size: 18),
                           andAlignment alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.font = font
        label.textColor = .ramrCream
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }

    private func makeStackView(withAxis axis: NSLayoutConstraint.Axis = .horizontal,
                               alignment: UIStackView.Alignment = .fill,
                               andDistribution distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = 0
        return stackView
    }
}

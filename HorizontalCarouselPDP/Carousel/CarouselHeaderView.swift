//
//  CarouselHeaderView.swift
//  HorizontalCarouselPDP
//
//  Created by Manas Aggarwal on 08/08/23.
//

import UIKit

final class CarouselHeaderView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let viewAllLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "arrow.right")
        return imageView
    }()
    
    private let viewAllStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.alignment = .center
        
        return stackView
    }()
    
    @objc
    func viewAllTapped() {
        print("ViewAll Tapped")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        
        setupViewsHierarchy()
        setupConstraints()
    }
    
    private func setupViewsHierarchy() {
        viewAllStackView.addArrangedSubview(viewAllLabel)
        viewAllStackView.addArrangedSubview(arrowImageView)
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(viewAllStackView)
        addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        containerStackView.setCustomSpacing(8, after: viewAllLabel)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configureHeader(title: String, ctaText: String?) {
        titleLabel.text = title
        if let ctaText = ctaText {
            viewAllStackView.isHidden = false
            viewAllLabel.text = ctaText
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewAllTapped))
            viewAllStackView.addGestureRecognizer(tapGesture)
        }
    }
}


//
//  ProductDetailTableViewCell.swift
//  HorizontalCarouselPDP
//
//  Created by Manas Aggarwal on 08/08/23.
//

import UIKit

final class ProductDetailTableViewCell: UITableViewCell {
    static let identifier = "ProductDetailTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func commonInit() {
        setupViewsHierarchy()
        setupConstraints()
    }
    
    private func setupViewsHierarchy() {
        contentStackView.addArrangedSubview(backdropImageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(overviewLabel)
        
        contentView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        contentStackView.setCustomSpacing(8, after: titleLabel)
        
        NSLayoutConstraint.activate(
            [
                backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 11 / 16, constant: 0),
                
                contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
                contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
            ]
        )
        
        preservesSuperviewLayoutMargins = false
    }
    
    func configure(movieDetail: MovieDetail) {
        if movieDetail.imageUrl.isEmpty {
            backdropImageView.isHidden = true
        }
        titleLabel.text = movieDetail.title
        overviewLabel.text = movieDetail.overview
    }
}

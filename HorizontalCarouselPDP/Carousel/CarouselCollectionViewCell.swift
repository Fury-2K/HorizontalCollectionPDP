//
//  CarouselCollectionViewCell.swift
//  HorizontalCarouselPDP
//
//  Created by Manas Aggarwal on 08/08/23.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CarouselCollectionViewCell"

//    private let posterImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 8
//
//        return imageView
//    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupViewsHierarchy()
        setupConstraints()
    }
    
    private func setupViewsHierarchy() {
//        containerStackView.addArrangedSubview(posterImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(genreLabel)
        
        contentView.addSubview(containerStackView)
    }
    
    private func setupConstraints() {
//        containerStackView.setCustomSpacing(0, after: titleLabel)
//        let bottomConstraint = containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            // PosterImageView
//            posterImageView.heightAnchor.constraint(equalToConstant: 212),
            
            // ContainerStackView
            containerStackView.widthAnchor.constraint(equalToConstant: 144),
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),// constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with movie: MovieDetail) {
        titleLabel.text = movie.title
        genreLabel.text = movie.overview
        
//        if !movie.imageUrl.isEmpty {
////            posterImageView.setImage(posterPath: path)
//        } else {
//            posterImageView.image = nil
//        }
    }
}


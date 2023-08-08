//
//  CollectionTableViewCell.swift
//  HorizontalCarouselPDP
//
//  Created by Manas Aggarwal on 08/08/23.
//

import UIKit

final class CollectionTableViewCell: UITableViewCell {
    static let identifier: String = "CollectionTableViewCell"
    
    private let headerView: CarouselHeaderView = {
        let header = CarouselHeaderView()
        return header
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(
            CarouselCollectionViewCell.self,
            forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    private var movies: [MovieDetail] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .cyan
        clipsToBounds = false
        layer.masksToBounds = false
        
        // CollectionView Setup
        collectionView.dataSource = self
        collectionView.delegate = self

        setupViewsHierarchy()
        setupConstraints()
    }
    
    private func setupViewsHierarchy() {
        addSubview(headerView)
        addSubview(collectionView)
        
        headerView.configureHeader(title: "Similar movies", ctaText: "View All")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // HeaderView
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // CollectionView
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with movies: [MovieDetail]) {
        self.movies = movies
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.layoutIfNeeded()
        collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width , height: 1)
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}

//
//  ProductDetailViewController.swift
//  HorizontalCarouselPDP
//
//  Created by Manas Aggarwal on 08/08/23.
//

import UIKit

struct MovieDetail {
    let title: String
    let overview: String
    let imageUrl: String
}

final class ProductDetailViewController: UITableViewController {
    private var movies: [MovieDetail] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List Page"
        
        tableView.largeContentTitle = "Movies"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        
        tableView.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: ProductDetailTableViewCell.identifier)
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        
        createDataSet(20)
    }
    
    private func createDataSet(_ count: Int) {
        var movieDetails: [MovieDetail] = []
        for index in 1...count {
            let overview: String
            if index == 6 {
                overview = "Some overview \(index)"
            } else {
                overview = "Movie overview with some random text going over multiple lines. Movie overview with some random text going over multiple lines. Movie overview with some random text going over multiple lines \(index)"
            }
            let movieDetail = MovieDetail(
                title: "Movie title \(index)",
                overview: overview,
                imageUrl: ""
            )
            movieDetails.append(movieDetail)
        }
        
        movies = movieDetails
    }
}

extension ProductDetailViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier) as? CollectionTableViewCell else { fatalError("Failed to dequeue") }
            cell.selectionStyle = .none
            cell.configure(with: movies)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier) as? ProductDetailTableViewCell else { fatalError("Failed to dequeue") }
            cell.selectionStyle = .none
            cell.configure(movieDetail: movies[indexPath.row > 1 ? indexPath.row + 1 : indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: - Niraj
        if indexPath.row == 1 {
            return 260
        } else {
            return UITableView.automaticDimension
        }
//        UITableView.automaticDimension
    }
}

//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/12.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    enum Constants {
        static let scrollViewInset: CGFloat = 15.0
    }

    private var movieDetailScrollView: MovieDetailScrollView?
    var movieDetailInformation: MovieInformation?
    var moviePosterImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        movieDetailScrollView = MovieDetailScrollView(frame: .zero)
        configureConstraints()
        setUpUI()
    }

    private func setUpUI() {
        guard let movieDetailInformation,
              let moviePosterImage else { return }
        self.navigationItem.title = movieDetailInformation.name
        movieDetailScrollView?.configureMoviewDetailView(with: movieDetailInformation, posterImage: moviePosterImage)
    }

    private func configureConstraints() {
        guard let movieDetailScrollView else { return }
        view.addSubview(movieDetailScrollView)

        movieDetailScrollView.translatesAutoresizingMaskIntoConstraints = false

        movieDetailScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        movieDetailScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.scrollViewInset).isActive = true
        movieDetailScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.scrollViewInset).isActive = true
        movieDetailScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }


}

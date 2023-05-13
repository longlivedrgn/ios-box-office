//
//  BoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/10.
//

import UIKit

final class BoxOfficeDetailView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white

        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear

        return contentView
    }()

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "square.and.arrow.up")

        return imageView
    }()

    private let directorKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "감독")
    private let yearOfProductionKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "제작년도")
    private let openDateKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "개봉일")
    private let runningTimeKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "상영시간")
    private let movieRatingKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "관람등급")
    private let nationKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "제작국가")
    private let genreKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "장르")
    private let actorsKeyLabel = DailyBoxOfficeDetailKeyLabel(text: "배우")

    private let directorValueLabel = DailyBoxOfficeDetailValueLabel()
    private let yearOfProductionValueLabel = DailyBoxOfficeDetailValueLabel()
    private let openDateValueLabel = DailyBoxOfficeDetailValueLabel()
    private let runningTimeValueLabel = DailyBoxOfficeDetailValueLabel()
    private let movieRatingValueLabel = DailyBoxOfficeDetailValueLabel()
    private let nationValueLabel = DailyBoxOfficeDetailValueLabel()
    private let genreValueLabel = DailyBoxOfficeDetailValueLabel()
    private let actorsValueLabel = DailyBoxOfficeDetailValueLabel()

    private lazy var directorInfoStackView = KeyValueInformationStackView(arrangedSubviews: [directorKeyLabel, directorValueLabel])
    private lazy var yearOfProductionInfoStackView = KeyValueInformationStackView(arrangedSubviews: [yearOfProductionKeyLabel, yearOfProductionValueLabel])
    private lazy var openDateInfoStackView = KeyValueInformationStackView(arrangedSubviews: [openDateKeyLabel, openDateValueLabel])
    private lazy var runningTimeInfoStackView = KeyValueInformationStackView(arrangedSubviews: [runningTimeKeyLabel, runningTimeValueLabel])
    private lazy var movieRatingInfoStackView = KeyValueInformationStackView(arrangedSubviews: [movieRatingKeyLabel, movieRatingValueLabel])
    private lazy var nationInfoStackView = KeyValueInformationStackView(arrangedSubviews: [nationKeyLabel, nationValueLabel])
    private lazy var genreInfoStackView = KeyValueInformationStackView(arrangedSubviews: [genreKeyLabel, genreValueLabel])
    private lazy var actorsInfoStackView = KeyValueInformationStackView(arrangedSubviews: [actorsKeyLabel, actorsValueLabel])

    private lazy var boxOfficeDetailStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [directorInfoStackView, yearOfProductionInfoStackView, openDateInfoStackView, runningTimeInfoStackView, movieRatingInfoStackView, nationInfoStackView, genreInfoStackView, actorsInfoStackView])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.axis = .vertical

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with movie: BoxOfficeDetailViewController.MovieDetailModel) {
        directorValueLabel.text = movie.director.description
        yearOfProductionValueLabel.text = movie.yearOfProduction
        openDateValueLabel.text = movie.openDate
        runningTimeValueLabel.text = "\(movie.runningTime)분"
        movieRatingValueLabel.text = movie.movieRating ?? "-"
        nationValueLabel.text = movie.nation ?? "-"
        genreValueLabel.text = movie.genres.description
        actorsValueLabel.text = movie.actors.description
    }

    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(boxOfficeDetailStackView)
    }

    private func configureLayout() {
        configureScrollViewConstraint()
        configureContentViewConstraint()
        configureImageViewConstraint()
        configureStackViewConstraint()
        configureKeyLabelConstraint()
    }

    private func configureScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func configureContentViewConstraint() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    private func configureImageViewConstraint() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.5).isActive = true
    }

    private func configureStackViewConstraint() {
        boxOfficeDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeDetailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        boxOfficeDetailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        boxOfficeDetailStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10).isActive = true
        boxOfficeDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func configureKeyLabelConstraint() {
        [directorKeyLabel, yearOfProductionKeyLabel, openDateKeyLabel, runningTimeKeyLabel, movieRatingKeyLabel, nationKeyLabel, genreKeyLabel, actorsKeyLabel].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalTo: boxOfficeDetailStackView.widthAnchor, multiplier: 0.3).isActive = true
        }
    }
}

//
//  BoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/10.
//

import UIKit

class BoxOfficeDetailView: UIView {

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
//        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let directorKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "감독"

        return label
    }()

    private let directorValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()

    private lazy var directorInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorKeyLabel, directorValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let yearOfProductionKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "제작년도"
        label.font = UIFont.boldSystemFont(ofSize: 20)

        return label
    }()

    private let yearOfProductionValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()

    private lazy var yearOfProductionInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearOfProductionKeyLabel, yearOfProductionValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let openDateKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "개봉일"

        return label
    }()

    private let openDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()

    private lazy var openDateInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [openDateKeyLabel, openDateValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let runningTimeKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "상영시간"

        return label
    }()

    private let runningTimeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()

    private lazy var runningTimeInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [runningTimeKeyLabel, runningTimeValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let movieRatingKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "관람등급"

        return label
    }()

    private let movieRatingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()
    
    private lazy var movieRatingInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieRatingKeyLabel, movieRatingValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let nationKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "제작국가"

        return label
    }()

    private let nationValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()

    private lazy var nationInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nationKeyLabel, nationValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let genreKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "장르"

        return label
    }()

    private let genreValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"

        return label
    }()

    private lazy var genreInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreKeyLabel, genreValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private let actorsKeyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "배우"

        return label
    }()

    private let actorsValueLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    private lazy var actorsInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actorsKeyLabel, actorsValueLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal

        return stackView
    }()

    private lazy var boxOfficeDetailStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [directorInfoStackView, yearOfProductionInfoStackView, openDateInfoStackView, runningTimeInfoStackView, movieRatingInfoStackView, nationInfoStackView, genreInfoStackView, actorsInfoStackView])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 15

        stackView.axis = .vertical

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 새로운 객체를 만드는 게 훨씬 효율적일듯!
    func configure(with movie: BoxOfficeDetailViewController.MovieDetailModel) {
        directorValueLabel.text = movie.director
        yearOfProductionValueLabel.text = movie.yearOfProduction
        openDateValueLabel.text = movie.openDate
        runningTimeValueLabel.text = movie.runningTime
        movieRatingValueLabel.text = movie.movieRating
        nationValueLabel.text = movie.nation
        genreValueLabel.text = "\(movie.genres)"
        actorsValueLabel.text = "\(movie.actors)"
    }

    private func setup() {
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
    }

    private func configureScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
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
        boxOfficeDetailStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true
        boxOfficeDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

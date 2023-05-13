//
//  MovieDetailScrollView.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/11.
//

import UIKit

final class MovieDetailScrollView: UIScrollView {

    static let identifier = String(describing: MovieDetailScrollView.self)

    private enum Constants {

        static let directorNameLableText: String = "감독"
        static let yearsOfProductionLabelText: String = "제작년도"
        static let openDateLabelText: String = "개봉일"
        static let runningTimeLabelText: String = "상영시간"
        static let movieRatingLabelText: String = "관람등급"
        static let nationLabelText: String = "제작국가"
        static let genresLabelText: String = "장르"
        static let actorsLabelText: String = "배우"

        static let posterImageHeight: CGFloat = 500
        static let labelWidthSize: CGFloat = 70.0
        static let textFontSize: CGFloat = 15.0
        static let labelBorderWidth: CGFloat = 1.0
        
    }

    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        return contentView
    }()

    private var moviePoster: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        return image
    }()

    private var directorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.directorNameLableText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var directorTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var yearsOfProductionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.yearsOfProductionLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var yearsOfProductionTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var openDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.openDateLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var openDateTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var runningTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.runningTimeLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var runningTimeTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.movieRatingLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var movieRatingTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var nationLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.nationLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var nationTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.genresLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var genresTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        return label
    }()

    private var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.textFontSize)
        label.text = Constants.actorsLabelText
        label.widthAnchor.constraint(equalToConstant: Constants.labelWidthSize).isActive = true
        label.textAlignment = .center
        return label
    }()
    private var actorsTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.textFontSize)
        label.numberOfLines = .zero
        return label
    }()

    private var directorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.layer.borderWidth = Constants.labelBorderWidth
        return stackView
    }()

    private var yearsOfProductionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var openDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var runningTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var movieRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var nationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var genresStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var actorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setContentView()
        configureHierarchy()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setContentView() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureHierarchy() {
        contentView.addSubview(moviePoster)

        contentView.addSubview(directorStackView)
        directorStackView.addArrangedSubview(directorNameLabel)
        directorStackView.addArrangedSubview(directorTextLabel)

        contentView.addSubview(yearsOfProductionStackView)
        yearsOfProductionStackView.addArrangedSubview(yearsOfProductionLabel)
        yearsOfProductionStackView.addArrangedSubview(yearsOfProductionTextLabel)

        contentView.addSubview(openDateStackView)
        openDateStackView.addArrangedSubview(openDateLabel)
        openDateStackView.addArrangedSubview(openDateTextLabel)

        contentView.addSubview(runningTimeStackView)
        runningTimeStackView.addArrangedSubview(runningTimeLabel)
        runningTimeStackView.addArrangedSubview(runningTimeTextLabel)

        contentView.addSubview(movieRatingStackView)
        movieRatingStackView.addArrangedSubview(movieRatingLabel)
        movieRatingStackView.addArrangedSubview(movieRatingTextLabel)

        contentView.addSubview(nationStackView)
        nationStackView.addArrangedSubview(nationLabel)
        nationStackView.addArrangedSubview(nationTextLabel)

        contentView.addSubview(genresStackView)
        genresStackView.addArrangedSubview(genresLabel)
        genresStackView.addArrangedSubview(genresTextLabel)

        contentView.addSubview(actorsStackView)
        actorsStackView.addArrangedSubview(actorsLabel)
        actorsStackView.addArrangedSubview(actorsTextLabel)
    }

    private func configureConstraints() {

        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviePoster.heightAnchor.constraint(equalToConstant: Constants.posterImageHeight),

            directorStackView.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 5),
            directorStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            directorStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            yearsOfProductionStackView.topAnchor.constraint(equalTo: directorStackView.bottomAnchor, constant: 5),
            yearsOfProductionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            yearsOfProductionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            openDateStackView.topAnchor.constraint(equalTo: yearsOfProductionStackView.bottomAnchor, constant: 5),
            openDateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            openDateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            runningTimeStackView.topAnchor.constraint(equalTo: openDateStackView.bottomAnchor, constant: 5),
            runningTimeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            runningTimeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            movieRatingStackView.topAnchor.constraint(equalTo: runningTimeStackView.bottomAnchor, constant: 5),
            movieRatingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieRatingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            nationStackView.topAnchor.constraint(equalTo: movieRatingStackView.bottomAnchor, constant: 5),
            nationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            genresStackView.topAnchor.constraint(equalTo: nationStackView.bottomAnchor, constant: 5),
            genresStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genresStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            actorsStackView.topAnchor.constraint(equalTo: genresStackView.bottomAnchor, constant: 5),
            actorsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actorsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actorsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }


    func configureMoviewDetailView(with movieInformation: MovieInformation, posterImage: UIImage ) {
        moviePoster.image = posterImage
        directorTextLabel.text = movieInformation.directors.map { $0.name }.joined(separator: ", ")
        yearsOfProductionTextLabel.text = movieInformation.yearOfProduction
        openDateTextLabel.text = movieInformation.yearOfProduction
        runningTimeTextLabel.text = movieInformation.runningTime
        movieRatingTextLabel.text = movieInformation.runningTime
        nationTextLabel.text = movieInformation.nations.map { $0.name }.joined(separator: ", ")
        genresTextLabel.text = movieInformation.genres.map { $0.name }.joined(separator: ", ")
        actorsTextLabel.text = movieInformation.actors.map { $0.name }.joined(separator: ", ")
    }


}

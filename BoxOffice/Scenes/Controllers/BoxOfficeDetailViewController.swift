//
//  BoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/10.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController {

    struct MovieDetailModel {
        let imageSearchName: String
        let director: [String]
        let yearOfProduction: String
        let openDate: String
        let runningTime: String
        let movieRating: String?
        let nation: String?
        let genres: [String]
        let actors: [String]
    }

    var movie: DailyBoxOffice?
    var networkAPIManager: NetworkAPIManager
    var networkDispatcher: NetworkDispatcher

    lazy var boxOfficeDetailView: BoxOfficeDetailView = {
        let view = BoxOfficeDetailView(frame: view.frame)

        return view
    }()

    init(movie: DailyBoxOffice, BoxOfficeAPIManager: NetworkAPIManager) {
        self.movie = movie
        self.networkAPIManager = BoxOfficeAPIManager
        self.networkDispatcher = BoxOfficeAPIManager.networkDispatcher
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(boxOfficeDetailView)
        fetchBoxOfficeDetailData()
    }

    private func fetchBoxOfficeDetailData() {
        fetchMovieInformation()
        fetchMovieImage()
    }

    private func fetchMovieInformation() {
        guard let movieCode = movie?.movieCode else { return }
        let movieDetailEndPoint = BoxOfficeAPIEndpoints.movieDetail(movieCode: movieCode)

        Task {
            let decodedMovieData = try await networkAPIManager.fetchData(
                to: MovieDetail.self,
                endPoint: movieDetailEndPoint)
            guard let movie = decodedMovieData as? MovieDetail else { return }
            let movieDetailModel = convertToMovieDetailModel(from: movie)
            self.boxOfficeDetailView.configure(with: movieDetailModel)
        }
    }

    private func fetchMovieImage() {
        guard let movieName = movie?.movieName else { return }
        let imageURLEndPoint = PosterImageAPIEndPoint.posterImage(name: movieName)

        Task {
            let decodedImageURLData = try await networkAPIManager.fetchData(to: ImageURL.self, endPoint: imageURLEndPoint)
            guard let imageURLModel = decodedImageURLData as? ImageURL else { return }
            guard let imageURLString = imageURLModel.documents.first?.imageURL else { return }
            guard let imageURL = URL(string: imageURLString) else { return }
            let imageURLRequest = URLRequest(url: imageURL)
            let imageResult = try await networkDispatcher.performRequest(imageURLRequest)

            switch imageResult {
            case .success(let data):
                boxOfficeDetailView.configureImage(with: data)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }

    private func convertToMovieDetailModel(from movie: MovieDetail) -> MovieDetailModel {
        let movieInformation = movie.movieInformationResult.movieInformation

        let movieName = movieInformation.name
        let imageSearchName = "\(movieName) 영화 포스터"
        let director = movieInformation.directors.map { $0.name }
        let openDate = movieInformation.openDate
        let yearOfProduction = movieInformation.yearOfProduction
        let runningTime = movieInformation.runningTime
        let movieRating = movieInformation.audits[safe: 0]?.movieRating
        let nation = movieInformation.nations[safe: 0]?.name
        let genres = movieInformation.genres.map { $0.name }
        let actors = movieInformation.actors.map { $0.name }

        return MovieDetailModel(
            imageSearchName: imageSearchName,
            director: director,
            yearOfProduction: yearOfProduction,
            openDate: openDate,
            runningTime: runningTime,
            movieRating: movieRating,
            nation: nation,
            genres: genres,
            actors: actors)
    }
}

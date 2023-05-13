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
    var BoxOfficeAPIManager: NetworkAPIManager?

    lazy var boxOfficeDetailView: BoxOfficeDetailView = {
        let view = BoxOfficeDetailView(frame: view.frame)

        return view
    }()

    convenience init(movie: DailyBoxOffice, BoxOfficeAPIManager: NetworkAPIManager) {
        self.init()
        self.movie = movie
        self.BoxOfficeAPIManager = BoxOfficeAPIManager
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(boxOfficeDetailView)
        fetchBoxOfficeDetailData()
    }

    private func fetchBoxOfficeDetailData() {
        guard let movieCode = movie?.movieCode else { return }
        guard let movieDetailEndPoint = BoxOfficeAPIEndpoints.movieDetail(movieCode: movieCode) as? APIEndpoint else { return }

        BoxOfficeAPIManager?.fetchData(
            to: MovieDetail.self,
            endPoint: movieDetailEndPoint) { [weak self] data in
                guard let movie = data as? MovieDetail else { return }
                guard let movieDetailModel = self?.convertToMovieDetailModel(from: movie) else { return }
                DispatchQueue.main.async {
                    self?.boxOfficeDetailView.configure(with: movieDetailModel)
                }
            }

        BoxOfficeAPIManager?.fetchData(to: ImageURL.self, endPoint: <#T##APIEndpoint#>, completionHandler: <#T##(Decodable) -> Void#>)

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

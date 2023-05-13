//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {

    private enum Section {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>

    private var loadingIndicatorView = UIActivityIndicatorView(style: .large)
    private let boxOfficeManager = BoxOfficeAPIManager()
    private var dailyBoxOfficeCollectionView: UICollectionView?
    private var dataSource: DataSource?
    private var movies = [DailyBoxOffice]() {
        didSet {
            applySnapShot()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureCollectionView()
        configureDataSource()
        showIndicatorview()
        fetchBoxOfficeData()
    }

    private func setUpUI() {
        view.backgroundColor = .systemBackground
    }

    private func configureCollectionView() {
        dailyBoxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        guard let dailyBoxOfficeCollectionView else { return }
        dailyBoxOfficeCollectionView.delegate = self
        dailyBoxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dailyBoxOfficeCollectionView)
        dailyBoxOfficeCollectionView.register(DailyBoxOfficeCell.self,
                                              forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
        configureCollectionViewLayoutConstraint()
        configureRefreshControl()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)

            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }

        return layout
    }

    private func configureCollectionViewLayoutConstraint() {
        guard let dailyBoxOfficeCollectionView else { return }
        let safeAreaGuide = view.safeAreaLayoutGuide
        dailyBoxOfficeCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor).isActive = true
        dailyBoxOfficeCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor).isActive = true
        dailyBoxOfficeCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        dailyBoxOfficeCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
    }

    private func configureDataSource() {
        guard let dailyBoxOfficeCollectionView else { return }
        dataSource = UICollectionViewDiffableDataSource(collectionView: dailyBoxOfficeCollectionView )
        { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCell.identifier,
                                                          for: indexPath) as? DailyBoxOfficeCell
            cell?.accessories = [.disclosureIndicator()]
            cell?.configure(with: movie)

            return cell
        }
    }

    private func fetchBoxOfficeData() {
        Task {
        showIndicatorview()

        let yesterDay = Date.yesterDayDateConvertToString()
        let yesterdayDashExcepted = yesterDay.without("-")
        let boxOffice = try await boxOfficeManager.fetchData(to: BoxOffice.self, endPoint: .boxOffice(targetDate: yesterdayDashExcepted))
            movies = boxOffice.result.dailyBoxOffices
            navigationItem.title = yesterDay
            self.endRefresh()
            self.removeIndicatorView()
        }
    }

    private func applySnapShot() {
        var snapShot = SnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(movies)

        DispatchQueue.main.async {
            self.dataSource?.apply(snapShot)
        }
    }

}

extension DailyBoxOfficeViewController {

    private func showIndicatorview() {
        loadingIndicatorView.frame = view.frame
        loadingIndicatorView.color = .systemBlue
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
    }
    
    private func removeIndicatorView() {
        loadingIndicatorView.removeFromSuperview()
    }

    private func configureRefreshControl() {
        guard let dailyBoxOfficeCollectionView else { return }

        dailyBoxOfficeCollectionView.refreshControl = UIRefreshControl()
        dailyBoxOfficeCollectionView.refreshControl?.addTarget(self,
                                                               action: #selector(handleRefreshControl),
                                                               for: .valueChanged)
    }

    private func endRefresh() {
        dailyBoxOfficeCollectionView?.refreshControl?.endRefreshing()
    }

    @objc private func handleRefreshControl() {
        fetchBoxOfficeData()
    }

}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMoiveCode = dataSource?.itemIdentifier(for: indexPath)?.movieCode else { return }
        let movieDetailView = MovieDetailViewController()
        Task {
            let movieDetail = try await boxOfficeManager.fetchData(to: MovieDetail.self, endPoint: .movieDetail(movieCode: selectedMoiveCode))
            let movieImageInformation = try await boxOfficeManager.fetchData(to: SearchedImage.self, endPoint: .movieImage(moiveName: movieDetail.movieInformationResult.movieInformation.name))

                movieDetailView.movieDetailInformation = movieDetail.movieInformationResult.movieInformation

                movieDetailView.moviePosterImage = UIImage(systemName: "x.circle")
                self.navigationController?.pushViewController(movieDetailView, animated: true)
        }
    }
}

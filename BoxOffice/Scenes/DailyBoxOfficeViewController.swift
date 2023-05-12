//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {

    enum Section {
        case main
    }

    enum Constants {
        static let formerNavigationItemTitle = "데이터 받아오는 중~!"
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>

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
        setUp()
        configureCollectionView()
        configureDataSource()
        configureRefreshControl()
        fetchBoxOfficeData()
    }

    private func setUp() {
        navigationItem.title = Constants.formerNavigationItemTitle
        view.backgroundColor = .systemBackground
    }

    private func configureCollectionView() {
        dailyBoxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        dailyBoxOfficeCollectionView?.delegate = self
        guard let dailyBoxOfficeCollectionView else { return }
        view.addSubview(dailyBoxOfficeCollectionView)
        dailyBoxOfficeCollectionView.register(DailyBoxOfficeCell.self,
                                              forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
        configureCollectionViewLayoutConstraint()
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

        dailyBoxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dailyBoxOfficeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dailyBoxOfficeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dailyBoxOfficeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dailyBoxOfficeCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
        showIndicatorview()
        let yesterDay = Date.yesterDayDateConvertToString()
        let yesterdayDashExcepted = yesterDay.except(for: "-")

        boxOfficeManager.fetchData(to: BoxOffice.self, endPoint: .boxOffice(targetDate: yesterdayDashExcepted))
        { [weak self] data in
            guard let boxOffice = data as? BoxOffice else { return }
            self?.movies = boxOffice.result.dailyBoxOfficeList
            DispatchQueue.main.async {
                self?.navigationItem.title = yesterDay
                self?.hideIndicatorView()
            }
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

    private func window() -> UIWindow {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return UIWindow() }

        return window
    }

    private func showIndicatorview() {
        let window = window()
        loadingIndicatorView.frame = window.frame
        loadingIndicatorView.color = .systemBlue
        window.addSubview(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
    }
    
    private func hideIndicatorView() {
        let window = window()
        let indicatorView = window.subviews.first { $0 is UIActivityIndicatorView }
        guard let indicatorView else { return }
        indicatorView.removeFromSuperview()
    }

    private func configureRefreshControl() {
        guard let dailyBoxOfficeCollectionView else { return }

        dailyBoxOfficeCollectionView.refreshControl = UIRefreshControl()
        dailyBoxOfficeCollectionView.refreshControl?.addTarget(self,
                                                               action: #selector(handleRefreshControl),
                                                               for: .valueChanged)
    }

    @objc private func handleRefreshControl() {
        self.dailyBoxOfficeCollectionView?.refreshControl?.endRefreshing()
    }

}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        dailyBoxOfficeCollectionView?.deselectItem(at: indexPath, animated: true)
        guard let movie = dataSource?.itemIdentifier(for: indexPath) else { return }
        let detailViewController = BoxOfficeDetailViewController(movie: movie, BoxOfficeAPIManager: boxOfficeManager)
        detailViewController.navigationItem.title = movie.movieName
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {

    private enum Section {
        case main
    }

    private enum Constant {
        static let navigationItemTitle = "데이터 받아오는 중!~"
        // 오늘 날짜 넣기~
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>!
    private var boxOfficeCollectionView: UICollectionView!
    private var loadingIndicatorView = UIActivityIndicatorView(style: .large)
    private let boxofficeAPIManager = BoxOfficeAPIManager()
    private var movies: [DailyBoxOfficeList]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureCollectionView()
        configureDataSource()
    }

    private func setup() {
        navigationItem.title = Constant.navigationItemTitle
        view.backgroundColor = .systemBackground
        showIndicatorView()

        boxofficeAPIManager.fetchData(to: BoxOffice.self,
                                      endPoint: BoxOfficeAPIEndpoints.boxOffice(targetDate: "20230429")) {
            [weak self] decodable in

            guard let boxoffice = decodable as? BoxOffice else { return }
            self?.movies = boxoffice.result.dailyBoxOfficeList
            self?.applySnapshot()
            DispatchQueue.main.async {
                self?.navigationItem.title = "2023-05-01"
                self?.hideIndicatorView()
            }
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)

        dataSource.apply(snapshot)
    }

    private func configureCollectionView() {
        boxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(boxOfficeCollectionView)
        configureCollectionViewLayout()
        registerCell(in: boxOfficeCollectionView)
    }

    private func configureCollectionViewLayout() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor).isActive = true
        boxOfficeCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor).isActive = true
        boxOfficeCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        boxOfficeCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
    }

    private func registerCell(in collectionView: UICollectionView) {
        collectionView.register(YesterdayBoxOfficeCell.self,
                                forCellWithReuseIdentifier: YesterdayBoxOfficeCell.identifier)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)

            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }

        return layout
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>(collectionView: boxOfficeCollectionView) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YesterdayBoxOfficeCell.identifier,
                                                          for: indexPath) as? YesterdayBoxOfficeCell
            cell?.accessories = [.disclosureIndicator()]
            cell?.configure(with: movie)

            return cell
        }
    }

}

extension BoxOfficeViewController {

    private func window() -> UIWindow {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return UIWindow() }

        return window
    }

    private func showIndicatorView() {
        let window = window()
        loadingIndicatorView.frame = window.frame
        loadingIndicatorView.color = .brown
        window.addSubview(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
    }

    private func hideIndicatorView() {
        let window = window()
        let indicatorView = window.subviews.first { $0 is UIActivityIndicatorView }
        guard let indicatorView = indicatorView else { return }
        indicatorView.removeFromSuperview()
    }

}

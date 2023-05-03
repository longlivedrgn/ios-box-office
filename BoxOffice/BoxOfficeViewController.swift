//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {

    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>!
    var boxOfficeCollectionView: UICollectionView!
    let boxofficeAPIManager = BoxOfficeAPIManager()
    var movies: [DailyBoxOfficeList]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "데이터 받아오는 중!~"
        setup()
        configureCollectionView()
        configureDataSource()
    }

    private func setup() {
        boxofficeAPIManager.fetchData(to: BoxOffice.self,
                                      endPoint: BoxOfficeAPIEndpoints.boxOffice(targetDate: "20230429")) {
            [weak self] decodable in

            guard let boxoffice = decodable as? BoxOffice else { return }
            self?.movies = boxoffice.result.dailyBoxOfficeList
            self?.applySnapshot()
            DispatchQueue.main.async {
                self?.navigationItem.title = "2023-05-01"
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
        boxOfficeCollectionView = UICollectionView(frame: view.bounds,
                                                   collectionViewLayout: createLayout())
        view.addSubview(boxOfficeCollectionView)
        registerCell(in: boxOfficeCollectionView)

    }

    private func registerCell(in collectionView: UICollectionView) {
        collectionView.register(YesterdayBoxOfficeCell.self,
                                forCellWithReuseIdentifier: YesterdayBoxOfficeCell.identifier)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.2))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            return section
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


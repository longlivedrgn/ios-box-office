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

    typealias dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>
    typealias snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>

    private var collectionView: UICollectionView?
    private var chartDataSource: dataSource?
    private var dailyBoxOfficeList: [DailyBoxOfficeList] = []
    private let boxOfficeManager = BoxOfficeAPIManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchBoxOfficeData()
    }

    private func setUpUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Today's Box Office"
        configureCollectionView()
        configureDataSourece()
        setCollectionVeiwLayout()
    }

    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())

        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self

        collectionView.register(BoxOfficeChartCell.self, forCellWithReuseIdentifier: BoxOfficeChartCell.identifier)

        self.collectionView = collectionView
    }

    private func setCollectionVeiwLayout() {
        guard let collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }

    private func generateLayout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            return section
        }
        return layout
    }

    private func snapshotForCurrentState(withAnimate animate: Bool) {
        var snapshot = snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeList)
        chartDataSource?.apply(snapshot, animatingDifferences: animate)
    }


    private func configureDataSourece() {
        guard let collectionView else { return }

        chartDataSource = dataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: DailyBoxOfficeList) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeChartCell.identifier, for: indexPath) as? BoxOfficeChartCell else { fatalError("Error: DataSource") }

            cell.configration(title: item.movieName , rank: item.rank, changes: item.dailyRankChanges, dailyAudience: item.audienceAccumulation, totalAudience: item.audienceAccumulation, oldAndNew: item.rankOldAndNew)

            cell.accessories = [.disclosureIndicator()]

            return cell
        }
        snapshotForCurrentState(withAnimate: false)
    }

    private func fetchBoxOfficeData() {
        boxOfficeManager.fetchData(to: BoxOffice.self, endPoint: .boxOffice(targetDate: "20230506")) { data in
            guard let boxOffice = data as? BoxOffice else { return }
            self.dailyBoxOfficeList = boxOffice.result.dailyBoxOfficeList
            self.snapshotForCurrentState(withAnimate: false)
        }
    }

}

extension BoxOfficeViewController: UICollectionViewDelegate {

}


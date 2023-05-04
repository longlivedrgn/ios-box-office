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
    private var chartSnapshot = snapshot()

    private var dailyBoxOfficeList: [DailyBoxOfficeList] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.chartSnapshot.appendItems(self!.dailyBoxOfficeList)
                self?.chartDataSource?.apply(self!.chartSnapshot)
            }
        }
    }

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
        snapshotForCurrentState()
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.21))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func snapshotForCurrentState() {
        chartSnapshot.appendSections([Section.main])
    }


    private func configureDataSourece() {
        guard let collectionView else { return }
        chartDataSource = dataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: DailyBoxOfficeList) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeChartCell.identifier, for: indexPath) as? BoxOfficeChartCell else { fatalError("Error: DataSource") }

            let dailyBoxOfficeList = self.dailyBoxOfficeList[indexPath.item]

            cell.configration(title: dailyBoxOfficeList.movieName , rank: dailyBoxOfficeList.rank, changes: dailyBoxOfficeList.dailyRankChanges, dailyAudience: dailyBoxOfficeList.audienceAccumulation, totalAudience: dailyBoxOfficeList.audienceAccumulation, oldAndNew: dailyBoxOfficeList.rankOldAndNew)

            cell.accessories = [.disclosureIndicator()]

            return cell
        }
        chartDataSource?.apply(chartSnapshot, animatingDifferences: false)
    }

    private func fetchBoxOfficeData() {
        boxOfficeManager.fetchData(to: BoxOffice.self, endPoint: .boxOffice(targetDate: "20230503")) { data in
            guard let boxOffice = data as? BoxOffice else { return }
            self.dailyBoxOfficeList = boxOffice.result.dailyBoxOfficeList
        }
    }

}

extension BoxOfficeViewController: UICollectionViewDelegate {

}


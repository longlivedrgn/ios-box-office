//
//  YesterdayBoxOfficeCell.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/02.
//

import UIKit

final class YesterdayBoxOfficeCell: UICollectionViewCell {
    static let identifier = "YesterdayBoxOfficeCell"

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let dailyRankChangesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        self.addSubview(nameLabel)
        self.addSubview(rankLabel)
        self.addSubview(audienceLabel)
        self.addSubview(dailyRankChangesLabel)
    }

    func configure(with movie: DailyBoxOfficeList) {
        nameLabel.text = movie.movieName
        rankLabel.text = movie.rank
        audienceLabel.text = movie.audienceAccumulation
        dailyRankChangesLabel.text = movie.dailyRankChanges
    }

    private func configureConstraints() {
        rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true

        nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true

        dailyRankChangesLabel.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor, constant: 2).isActive = true
        dailyRankChangesLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 5).isActive = true

        audienceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        audienceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    }

}

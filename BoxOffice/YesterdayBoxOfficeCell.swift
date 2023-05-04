//
//  YesterdayBoxOfficeCell.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/02.
//

import UIKit

final class YesterdayBoxOfficeCell: UICollectionViewListCell {

    static let identifier = "YesterdayBoxOfficeCell"

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let dailyRankChangesLabel: UILabel = {
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
        audienceLabel.text = generateAudienceLabelText(with: movie)
        setDailyRankChangesLabelText(with: movie)
    }

    private func generateAudienceLabelText(with movie: DailyBoxOfficeList) -> String {
        guard let audienceAccumulationNumber = Int(movie.audienceAccumulation) else { return "" }
        guard let audienceCountNumber = Int(movie.audienceCount) else { return "" }

        guard let audienceAccumulation = numberFormatter.string(for: audienceAccumulationNumber) else {
            return String(audienceAccumulationNumber)
        }
        guard let dailyAudienceCount = numberFormatter.string(for: audienceCountNumber) else {
            return String(audienceCountNumber)
        }

        let audienceLabelText = "오늘 \(dailyAudienceCount) / 총 \(audienceAccumulation)"

        return audienceLabelText
    }

    private func setDailyRankChangesLabelText(with movie: DailyBoxOfficeList) {

        switch movie.rankOldAndNew {
        case .new:
            dailyRankChangesLabel.text = "신작"
            dailyRankChangesLabel.textColor = UIColor.red
            return
        case .old:
            setOldRankChangesLabelText(with: movie)
            return
        }
    }

    private func setOldRankChangesLabelText(with movie: DailyBoxOfficeList) {
        guard let dailyRankChanges = Int(movie.dailyRankChanges) else { return }

        if dailyRankChanges > 0 {
            let image = UIImage(systemName: "arrowtriangle.up.fill")?.withTintColor(.red)
            let dailytRankChangesText = generateRankChangesAttributedText(movie.dailyRankChanges,
                                                                          with: image)
            dailyRankChangesLabel.attributedText = dailytRankChangesText
        } else if dailyRankChanges < 0 {
            let image = UIImage(systemName: "arrowtriangle.down.fill")?.withTintColor(.blue)
            let dailytRankChangesText = generateRankChangesAttributedText(movie.dailyRankChanges,
                                                                          with: image)
            dailyRankChangesLabel.attributedText = dailytRankChangesText
        } else {
            dailyRankChangesLabel.text = "-"
        }
    }

    private func generateRankChangesAttributedText(_ text: String,
                                                   with image: UIImage?) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image

        let rankChangesAttributedText = NSMutableAttributedString(attachment: attachment)
        let text = NSAttributedString(string: text)
        rankChangesAttributedText.append(text)

        return rankChangesAttributedText
    }

    private func configureConstraints() {
        let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 80)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        rankLabel.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true

        nameLabel.leadingAnchor.constraint(equalTo: rankLabel.centerXAnchor, constant: 35).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true

        dailyRankChangesLabel.centerXAnchor.constraint(equalTo: rankLabel.centerXAnchor).isActive = true
        dailyRankChangesLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 5).isActive = true

        audienceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        audienceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    }

}

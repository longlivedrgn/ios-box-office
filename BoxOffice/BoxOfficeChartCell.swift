//
//  BoxOfficeChartCell.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/03.
//

import UIKit

final class BoxOfficeChartCell: UICollectionViewListCell {

    //MARK: - Constants
    private enum Constants {
        static let movieTitleSkeletonText: String = "-"
        static let rankedNumberSkeletonText: String = "-"
        static let rankStateSkeletonText: String = "-"
        static let rankUpState: String = "▲"
        static let rankDownState: String = "▼"
        static let rankNewState: String = "New"
        static let today: String = "Today"
        static let total: String = "Total"
        static let audienceAmoutSkeletonText: String = "\(Constants.today) - / \(Constants.total) -"

        static let movieTitleFontSize: CGFloat = 21.0
        static let audienceFontSize: CGFloat = 17.0
        static let rankedNumberFontSize: CGFloat = 35.0
        static let rankChangesFontSize: CGFloat = 17.0

        static let rankStackViewWidth: CGFloat = 80

        static let rankStackViewleadingInset: CGFloat = 10
        static let rankStackViewInset: CGFloat = 7.0
        static let titleStackViewInset: CGFloat = 16.0
    }

    //MARK: - Properties

    static let identifier = String(describing: BoxOfficeChartCell.self)

    private var rankedNumber: UILabel = {
        let label = UILabel()
        label.text = Constants.rankedNumberSkeletonText
        label.font = UIFont.systemFont(ofSize: Constants.rankedNumberFontSize)

        return label
    }()

    private var rankState: UILabel = {
        let label = UILabel()
        label.text = Constants.rankStateSkeletonText
        label.font = UIFont.systemFont(ofSize: Constants.rankChangesFontSize)
        return label
    }()

    private var movieTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.movieTitleSkeletonText
        label.font = UIFont.systemFont(ofSize: Constants.movieTitleFontSize)
        label.sizeToFit()

        return label
    }()

    private var audienceStatus: UILabel = {
        let label = UILabel()
        label.text = Constants.audienceAmoutSkeletonText
        label.font = UIFont.systemFont(ofSize: Constants.audienceFontSize)
        label.sizeToFit()

        return label
    }()

    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()

    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setStackViews()
        setLayoutConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private
    private func setStackViews() {
        rankStackView.addArrangedSubview(rankedNumber)
        rankStackView.addArrangedSubview(rankState)
        titleStackView.addArrangedSubview(movieTitle)
        titleStackView.addArrangedSubview(audienceStatus)
        addSubview(rankStackView)
        addSubview(titleStackView)
    }

    private func setLayoutConfiguration() {

        translatesAutoresizingMaskIntoConstraints = false
        let cellHeight = contentView.heightAnchor.constraint(equalToConstant: 80)
        cellHeight.priority = .defaultHigh
        cellHeight.isActive = true

        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalToConstant: Constants.rankStackViewWidth),
            rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.rankStackViewInset),
            rankStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.rankStackViewInset),
            rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.rankStackViewleadingInset)
        ])

        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleStackViewInset),
            titleStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.titleStackViewInset),
            titleStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: .zero),
        ])
    }

    private func rankState(rankChanges: String) -> NSMutableAttributedString {

        let text = NSMutableAttributedString(string: Constants.rankStateSkeletonText)
        guard let changes = Int(rankChanges) else { return text }
        if changes == 0 { return text }
        return  generateArrowWithNumber(changes: changes)
    }

    private func generateArrowWithNumber(changes: Int) -> NSMutableAttributedString {
        let number = String(abs(changes))

        if changes > 0 {
            let rankState = Constants.rankUpState + number
            let mutableAttributedString = NSMutableAttributedString(string: rankState)
            mutableAttributedString.addAttributes([.foregroundColor: UIColor.systemRed], range: NSRange(location: 0, length: 1))
            return mutableAttributedString
        }
        if changes < 0 {
            let rankState = Constants.rankDownState + number
            let mutableAttributedString = NSMutableAttributedString(string: rankState)
            mutableAttributedString.addAttributes([.foregroundColor: UIColor.systemBlue], range: NSRange(location: 0, length: 1))
            return mutableAttributedString
        }

        return NSMutableAttributedString()
    }

    //MARK: - Pulblic
    func configration(title: String, rank: String, changes: String, dailyAudience: String, totalAudience: String, oldAndNew: RankOldAndNew) {
        self.movieTitle.text = title
        self.rankedNumber.text = rank
        self.audienceStatus.text = "\(Constants.today) \(dailyAudience) / \(Constants.total) \(totalAudience)"

        switch oldAndNew {
        case .new:
            self.rankState.text = Constants.rankNewState
        case .old:
            self.rankState.attributedText = rankState(rankChanges: changes)
        }
    }
}

//
//  DailyBoxOfficeDetailKeyLabel.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/12.
//

import UIKit

class DailyBoxOfficeDetailKeyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(text: String) {
        self.init(frame: CGRect())
        self.text = text
        configureUI()
    }

    private func configureUI() {
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.textAlignment = .center
    }
}

//
//  Array+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/10.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

//
//  ImageURL.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/12.
//

import Foundation

struct ImageURL: Decodable {
    let documents: [Document]
}

struct Document: Decodable {
    let imageURL: String


    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}

//
//  SearchedImage.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/13.
//

import Foundation

// MARK: - Welcome
struct SearchedImage: Decodable {
    let result: [ImageInformation]

    enum CodingKeys: String, CodingKey {
        case result = "documents"
    }
}

// MARK: - Document
struct ImageInformation: Decodable {
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}

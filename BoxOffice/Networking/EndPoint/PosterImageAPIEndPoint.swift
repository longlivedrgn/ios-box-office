//
//  PosterImageAPIEndPoint.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/12.
//

import Foundation

enum PosterImageAPIEndPoint: APIEndpoint {

    case posterImage(name: String)

}

extension PosterImageAPIEndPoint {

    private enum QueryConstant {
        static let pageQueryName = "page"
        static let pageQueryValue = "1"
        static let sizeQueryName = "size"
        static let sizeQueryValue = "1"
        static let authorizationHeaderName = "Authorization"
        static let authorizationHeaderValue = "KakaoAK 9c2937b80b564cc9b6dcfb82e5c548a2"
    }

    var searchQueryValue: String {
        switch self {
        case .posterImage(let name):
            return "\(name) 영화 포스터"
        }
    }

    var endPoint: EndPoint {
        return EndPoint(baseURL: "https://dapi.kakao.com/", path: "/v2/search/image", queryItems: makeQueryItems(), headers: [QueryConstant.authorizationHeaderName: QueryConstant.authorizationHeaderValue])
    }

    func makeQueryItems() -> [URLQueryItem] {
        let sizeQueryItem = URLQueryItem(name: QueryConstant.pageQueryName,
                                           value: QueryConstant.pageQueryValue)
        let pageQueryItem = URLQueryItem(name: QueryConstant.sizeQueryName,
                                         value: QueryConstant.sizeQueryValue)
        let imageSearchQueryItem = URLQueryItem(name: "query", value: searchQueryValue)

        return [sizeQueryItem, pageQueryItem, imageSearchQueryItem]
    }

}

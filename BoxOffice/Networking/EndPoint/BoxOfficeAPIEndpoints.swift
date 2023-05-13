//
//  BoxOfficeAPIEndpoints.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/25.
//

import Foundation

enum BoxOfficeAPIEndpoints {

    case boxOffice(targetDate: String)
    case movieDetail(movieCode: String)
    case movieImage(moiveName: String)

}

extension BoxOfficeAPIEndpoints {

    private var endPoint: EndPoint {
        switch self {
        case .boxOffice:
            return EndPoint(baseURL: "https://www.kobis.or.kr",
                            path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                            queryItems: makeQueryItems())
        case .movieDetail:
            return EndPoint(baseURL: "https://www.kobis.or.kr",
                            path: "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
                            queryItems: makeQueryItems())
        case .movieImage:
            return EndPoint(baseURL: "https://dapi.kakao.com", path: "/v2/search/image",
                            queryItems: makeQueryItems())
        }
    }

    var urlRequest: URLRequest? {
        var urlCompoenets = URLComponents(string: endPoint.baseURL)

        urlCompoenets?.path = endPoint.path
        urlCompoenets?.queryItems = endPoint.queryItems

        guard let url = urlCompoenets?.url else { return nil }
        var urlRequest = URLRequest(url: url)

        if case .movieImage(_) = self {
            urlRequest.setValue("KakaoAK e37dbfb127b8ed041816c0ddd0c96a4a", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }

    private enum QueryConstant {
        static let apiKeyQueryName = "key"
        static let apiKeyQueryValue = "6c4b02fc76306e47a3ada0534d4cc519"
        static let movieCodeQueryName = "movieCd"
        static let targetDateQueryName = "targetDt"

        static let kakaoSearchTargetQueryName = "query"
        static let kakaoSearchSizeQueryName = "size"
        static let kakaoSearchPageQueryName = "page"
        static let stringNumberOne = "1"
    }
    
    private func makeQueryItems() -> [URLQueryItem] {
        let apiKeyQueryItem = URLQueryItem(name: QueryConstant.apiKeyQueryName,
                                           value: QueryConstant.apiKeyQueryValue)
        switch self {
        case .boxOffice(let date):
            let dateQueryItem = URLQueryItem(name: QueryConstant.targetDateQueryName,
                                             value: date)
            return [apiKeyQueryItem, dateQueryItem]

        case .movieDetail(let code):
            let movieCodeQueryItem = URLQueryItem(name: QueryConstant.movieCodeQueryName,
                                                  value: code)
            return [apiKeyQueryItem, movieCodeQueryItem]

        case . movieImage(let movieName):
            let movieNameQueryItem = URLQueryItem(name: QueryConstant.kakaoSearchTargetQueryName,
                                                  value: movieName)
            let resultSizeQueryItem = URLQueryItem(name: QueryConstant.kakaoSearchSizeQueryName,
                                                   value: QueryConstant.stringNumberOne)
            let resultPageQueryItem = URLQueryItem(name: QueryConstant.kakaoSearchPageQueryName,
                                                   value: QueryConstant.stringNumberOne)
            return [movieNameQueryItem, resultSizeQueryItem, resultPageQueryItem]
        }
    }
    
}


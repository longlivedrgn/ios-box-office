//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//
import Foundation

struct BoxOffice: Decodable {

    let result: BoxOfficeResult

    enum CodingKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }

}

struct BoxOfficeResult: Decodable {

    let type: String
    let rangeOfDate: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]

    enum CodingKeys: String, CodingKey {
        case type = "boxofficeType"
        case rangeOfDate = "showRange"
        case dailyBoxOfficeList
    }

}

struct DailyBoxOfficeList: Decodable, Hashable {

    let orderNumber: String
    let rank: String
    let dailyRankChanges: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let audienceAccumulation: String
    let identifer = UUID()

    enum CodingKeys: String, CodingKey {
        case orderNumber = "rnum"
        case rank
        case dailyRankChanges = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case audienceAccumulation = "audiAcc"
    }

    static func == (lhs: DailyBoxOfficeList, rhs: DailyBoxOfficeList) -> Bool {
        lhs.identifer == rhs.identifer
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifer)
    }

}

enum RankOldAndNew: String, Decodable {

    case new = "NEW"
    case old = "OLD"

}

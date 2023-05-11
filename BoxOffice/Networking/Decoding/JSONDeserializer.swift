//
//  JSONDeserializer.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/24.
//

import Foundation

final class JSONDeserializer {

    private let decoder = JSONDecoder()

    func deserialize<T: Decodable>(type: T.Type, data: Data) throws -> T {
        try decoder.decode(type.self, from: data)
    }

}

//
//  NetworkDispatcher.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/27.
//

import Foundation


struct NetworkDispatcher {

    typealias NetworkResult = Result<Data, NetworkError>

    func performRequest(_ urlRequest: URLRequest?) async throws -> Data
    {
        let session = URLSession.shared

        guard let urlRequest else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.isValidResponse else {
            print(NetworkError.outOfResponseCode)
            throw NetworkError.outOfResponseCode
        }

        return data
    }

}

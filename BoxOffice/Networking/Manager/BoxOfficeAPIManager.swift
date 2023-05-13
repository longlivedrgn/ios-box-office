//
//  BoxOfficeAPIManager.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/04/27.
//

import Foundation

struct BoxOfficeAPIManager {
    
    private let deserializer = JSONDeserializer()
    private let networkDispatcher = NetworkDispatcher()
    
    func fetchData<T: Decodable>(to type: T.Type,
                   endPoint: BoxOfficeAPIEndpoints) async throws -> T {

        guard let urlRequest = endPoint.urlRequest else { throw NetworkError.invalidURL }
        guard let data = try? await networkDispatcher.performRequest(urlRequest) else { throw NetworkError.emptyData}
        let decodedData = try self.deserializer.deserialize(type: T.self, data: data)
        return decodedData
    }
    
}

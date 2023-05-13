//
//  APIEndPoint.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/12.
//

import UIKit

protocol APIEndpoint {

    var endPoint: EndPoint { get }
    var urlRequest: URLRequest? { get }
    func makeQueryItems() -> [URLQueryItem]

}

extension APIEndpoint {

    var urlRequest: URLRequest? {
        var urlCompoenets = URLComponents(string: endPoint.baseURL)

        urlCompoenets?.path = endPoint.path
        urlCompoenets?.queryItems = endPoint.queryItems

        guard let url = urlCompoenets?.url else { return nil }
        var urlRequest = URLRequest(url: url)
        endPoint.headers?.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }

}

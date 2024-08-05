//
//  NetworkEngine.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

enum NetworkError: Error {
    case inValidEndPoint //Failed to turn EndPoint into valid url request
    case failed(statusCode: Int)
    case invalidResponse
    case parsingError
    case unknownError
}

final class NetworkEngine {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func makeRequest<T: Decodable>(for endpoint: Endpoint) async -> Result<T, NetworkError> {
        guard let urlRequest = endpoint.generateURLRequest() else {
            return .failure(.inValidEndPoint)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            guard let urlResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            if urlResponse.statusCode == 200 {
                do {
                    let requestedModel = try JSONDecoder().decode(T.self, from: data)
                    return .success(requestedModel)
                } catch {
                    return .failure(.parsingError)
                }
            } else {
                return .failure(.failed(statusCode: urlResponse.statusCode))
            }
        } catch {
            return .failure(.unknownError)
        }
    }
}


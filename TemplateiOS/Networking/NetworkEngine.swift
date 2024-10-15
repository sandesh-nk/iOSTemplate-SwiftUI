//
//  NetworkEngine.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation
import Combine

final class NetworkEngine<E: Endpoint> {
    private let urlSession: URLSession
    private let mockRquest: Bool
    
    init(urlSession: URLSession = .shared, mockRquest: Bool) {
        self.urlSession = urlSession
        self.mockRquest = mockRquest
    }
    
    ///  Makes network request for given endpoint
    ///  - Parameters:
    ///  - endpoint: instance of type `Endpoint` representing url request endpoint
    ///  - Returns: AnyPublisher<T, NetworkError>, where T is Decodable
    func makeRequest<T: Decodable>(for endpoint: E) async -> AnyPublisher<T, NetworkError> {
        
        guard let urlRequest = endpoint.generateURLRequest() else {
            return Fail<T, NetworkError>(error: .inValidEndPoint)
                .eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                if urlResponse.statusCode == 200 {
                    do {
                        let requestedModel = try JSONDecoder().decode(T.self, from: data)
                        return requestedModel
                    } catch {
                        throw NetworkError.parsingError
                    }
                } else { throw NetworkError.invalidResponse}
            }
            .map { $0 }
            .mapError { $0 as? NetworkError ?? .unknownError }
            .eraseToAnyPublisher()
    }
    
    ///  Makes network request for given endpoint
    ///  - Parameters:
    ///  - endpoint: instance of type `Endpoint` representing url request endpoint
    ///  - Returns: Result<T, NetworkError>, where T is Decodable
    func makeRequest<T: Decodable>(for endpoint: E) async -> Result<T, NetworkError> {
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

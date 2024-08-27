//
//  APIClient.swift
//  TemplateiOS
//
//  Created by Wednesday on 21/08/24.
//

import Foundation
import Moya
import CombineMoya
import Combine

/// A protocol for requesting an API
protocol APIRequestable {
    ///  The type of `TargetType` enum from Moya
    associatedtype Target

    /// Designated request-making method using combine api's
    /// - Parameter target: TargetType enum value for API
    /// - Returns: `AnyPublisher<Model, APIError>`where Model is Decodable
    func request<Model: Decodable>(target: Target) -> AnyPublisher<Model, NetworkError>
    
    /// Designated request-making method
    /// - Parameter target: TargetType enum value for API
    /// - Returns: `Result<Model, NetworkError>`where Model is Decodable
    func request<Model: Decodable>(target: Target) async throws -> Result<Model, NetworkError>
}

/// A class which conforms `APIClientRequestable` protocol to handle all networking methods
final class APIClient<T:TargetType> {

    private var isMockRequest: Bool = false

    /// Need to create a `public` initializer because by default `internal` protection
    /// does not allow to create an instance outside this framework
    public init(isMockRequest: Bool = false) {
        self.isMockRequest = isMockRequest

        // Enabling Moya logger only for DEBUG mode
        #if DEBUG
        provider = MoyaProvider<T>(
            plugins: [
                NetworkLoggerPlugin(
                    configuration: .init(logOptions: .verbose)
                )
            ]
        )
        #else
        provider = MoyaProvider<T>()
        #endif
    }

    /// A generic `Moya` provider used for making API request
    private let provider: MoyaProvider<T>
    /// A generic  mock`Moya` provider used for  stubbing mock API request
    private let mockProvider = MoyaProvider<T>(stubClosure: MoyaProvider.immediatelyStub(_:))
}

extension APIClient: APIRequestable {
    
    // API call using Moya publisher call (Combine implementation)
    func request<Model: Decodable>(target: T) -> AnyPublisher<Model, NetworkError> {
        let provider = isMockRequest ? mockProvider : provider
        return provider.requestPublisher(target)
            .tryMap { response in
                guard response.statusCode == 200 else {
                    throw NetworkError.inValidEndPoint
                }
                
                let successResponse = try response.filterSuccessfulStatusCodes()
                return try successResponse.map(Model.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false)
            }
            .mapError { _ in
                // MARK: - Here the error is of type MoyaError this can be handled further if needed
                return NetworkError.unknownError
            }
            .eraseToAnyPublisher()
    }
    
    // API call using Moya publisher call (asyn/await implementation)
    func request<Model: Decodable>(target: T) async -> Result<Model, NetworkError> {
        let provider = isMockRequest ? mockProvider : provider
        return await withCheckedContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    guard response.statusCode == 200 else {
                        continuation.resume(returning: .failure(.inValidEndPoint))
                        return
                    }
                    guard let successResponse = try? response.filterSuccessfulStatusCodes() else {
                        continuation.resume(returning: .failure(.invalidResponse))
                        return
                    }
                    guard let model = try? successResponse.map(Model.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false) else {
                        continuation.resume(returning: .failure(.parsingError))
                        return
                    }
                    continuation.resume(returning: .success(model))
                case .failure(_):
                    // MARK: - Here the error is of type MoyaError this can be handled further if needed
                    continuation.resume(returning: .failure(.unknownError))
                }
            }
        }
    }
    
}

//
//  GeckoCoinsService.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import Foundation
import Combine

protocol GeckoCoinsServiceProtocol {
    func getCoins() async -> AnyPublisher<[Coin], NetworkError>
    func getCoinDetails() async -> AnyPublisher<Coin, NetworkError>
}

struct GeckoCoinsService: GeckoCoinsServiceProtocol {
    private let network: NetworkEngine<GeckoCoinsEndpoint>
    
    init(isMockEnabled mock: Bool = false) {
        network = .init(mockRquest: mock)
    }

    func getCoins() async -> AnyPublisher<[Coin], NetworkError> {
       return await network.makeRequest(for: .getCoinList)
    }

    func getCoinDetails() async -> AnyPublisher<Coin, NetworkError> {
        return await network.makeRequest(for: .getCoinDetails)
    }
}

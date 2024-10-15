//
//  GeckoCoinsEndpoint.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import Foundation

enum GeckoCoinsEndpoint {
    case getCoinList
    case getCoinDetails
}

extension GeckoCoinsEndpoint: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return AppConfig.baseUrl
    }
    
    var path: String {
        switch self {
        case .getCoinList:
            "/api/v3/coins/markets"
        case .getCoinDetails:
            ""
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getCoinList:
            return [URLQueryItem(name: "vs_currency", value: "inr"),
                    URLQueryItem(name: "per_page", value: "20")]
        case .getCoinDetails:
            return []
        }
    }
    
    var method: String {
        return "GET"
    }
}

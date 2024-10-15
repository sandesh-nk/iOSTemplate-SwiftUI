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
        return ""
    }
    
    var baseURL: String {
        return ""
    }
    
    var path: String {
        return ""
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return ""
    }
    
    
}

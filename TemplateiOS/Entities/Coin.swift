//
//  Coin.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import Foundation

struct Coin: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Double
    let totalVolume: Double
    let high24Hour: Double
    let low24Hour: Double
    let priceChange24Hour: Double
    let percentageChage24Hours: Double
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24Hour = "high_24h"
        case low24Hour = "low_24h"
        case priceChange24Hour = "price_change_24h"
        case percentageChage24Hours = "price_change_percentage_24h"
        case lastUpdated = "last_updated"
    }
    
    var imageURL: URL? {
        URL(string: image)
    }
    
    var is24HourChangePositive: Bool {
        priceChange24Hour >= 0
    }
}

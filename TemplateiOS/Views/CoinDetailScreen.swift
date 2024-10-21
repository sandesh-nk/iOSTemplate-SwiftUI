//
//  CoinDetailScreen.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 21/10/24.
//

import SwiftUI

struct CoinDetailScreen: View {
    
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center) {
                AsyncImage(url: coin.imageURL) { phase in
                    switch phase {
                    case .empty:
                        // show loader ideally
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                    case .failure:
                        Image(systemName: "questionmark.circle")
                            .resizable()
                    @unknown default:
                        EmptyView()
                    }
                    
                }
                .frame(width: 150, height: 150)
                .shadow(radius: 16, x: 1, y: 1)
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
    }
}

#Preview {
    let coin = Coin(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image:
            "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 5_515_438,
        marketCap: 108_978_578_716_723,
        marketCapRank: 1,
        totalVolume: 3_494_260_891_717,
        high24Hour: 5_589_271,
        low24Hour: 5_433_745,
        priceChange24Hour: 72227,
        percentageChage24Hours: 1.32693,
        lastUpdated: "2024-10-15T09:46:53.590Z"
    )
    
    CoinDetailScreen(coin: coin)
}

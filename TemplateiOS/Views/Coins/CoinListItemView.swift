//
//  CoinListItemView.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 15/10/24.
//

import SwiftUI

struct CoinListItemView: View {
    private var coin: Coin

    init(coin: Coin) {
        self.coin = coin
    }

    var body: some View {
        ZStack {
            HStack {
                HStack(spacing: 16) {
                    coinImageView(coin)
                    coinInfoView
                }
                Spacer()
                coinPriceView
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
    }

    private func coinImageView(_ coin: Coin) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.10))
            .frame(width: 64, height: 64)
            .overlay {
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
                .frame(width: 40, height: 40)
            }
    }

    private var coinInfoView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(coin.symbol.uppercased())
                .font(.system(size: 20, weight: .bold))
            Text(coin.name)
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
        }
    }

    private var formattedCurrentPrice: String {
        coin.currentPrice.formatted(
            .currency(code: "INR").precision(.fractionLength(0)))
    }

    private var coinPriceView: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(formattedCurrentPrice)
                .font(.system(size: 16, weight: .bold))
            priceChangePercentageView
        }
    }

    private var formattedPriceChangePercentage: String {
        (coin.percentageChage24Hours / 100).formatted(
            .percent.precision(.fractionLength(2)))
    }

    private var priceChangePercentageView: some View {
        HStack {
            Image(
                systemName: coin.is24HourChangePositive
                    ? "arrow.up.right" : "arrow.down.left"
            )
            Text(formattedPriceChangePercentage)
               
        }
        .font(.system(size: 10, weight: .bold))
        .foregroundStyle(.white)
        .padding(.vertical, 2)
        .padding(.horizontal, 4)
        .background(coin.is24HourChangePositive ? Color.green : Color.red)
        .clipShape(Capsule())
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

    Color.gray.opacity(0.2)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            CoinListItemView(coin: coin)
        }
}

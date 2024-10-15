//
//  CoinListView.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import SwiftUI

struct CoinListView: View {
    
    @ObservedObject private var model: CoinsModel
    
    init(model: CoinsModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            header
            ScrollView(showsIndicators: false) {
                ForEach(model.coins) { coin in
                    CoinListItemView(coin: coin)
                }
                .padding(.horizontal)
            }
            .background(Color.gray.opacity(0.15))
        }
        .task {
            await model.fetchgeckoCoins()
        }
    }
    
    private var header: some View {
        HStack(spacing: 8) {
            Image(systemName: "person")
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color.gray)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Hello")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.gray)
                Text("User")
                    .font(.system(size: 20, weight: .bold))
            }
            Spacer()
            Image(systemName: "bell")
                .frame(width: 40, height: 40, alignment: .center)
        }
    }
}

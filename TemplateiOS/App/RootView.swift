//
//  RootView.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: WTab = .coins

    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    CoinListScreen(model: CoinsModel())
                        .tag(WTab.coins)
                    
                    Text("Hello")
                        .tag(WTab.favorites)
                    
                    Text("Hello")
                        .tag(WTab.profile)
                }
                WTabView(currentTab: $selectedTab)
            }
        }
    }
}

#Preview {
    RootView()
}

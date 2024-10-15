//
//  RootView.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        NavigationStack {
            CoinListView()
        }
    }
}

#Preview {
    RootView()
}

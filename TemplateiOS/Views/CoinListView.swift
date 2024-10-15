//
//  CoinListView.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import SwiftUI

struct CoinListView: View {
        
    var body: some View {
        VStack {
            header
        }
        .padding(.horizontal, 15)
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

#Preview {
    CoinListView()
}

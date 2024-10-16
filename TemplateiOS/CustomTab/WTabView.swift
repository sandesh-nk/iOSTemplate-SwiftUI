//
//  WTabView.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 16/10/24.
//

import SwiftUI

struct WTabView: View {
    @Binding var currentTab: WTab
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                ForEach(WTab.allCases, id: \.self) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        VStack {
                            Image(systemName: currentTab == tab ? tab.systemIcon.appending(".fill") : tab.systemIcon)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .aspectRatio(contentMode: .fit)
                                
                            Text(tab.title)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.green)
                    }
                   
                }
                .padding(.top, 8)
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
        }
        .frame(height: 40)
        .fixedSize(horizontal: false, vertical: true)
        
    }
}

#Preview {
    WTabView(currentTab: .constant(.coins))
}

//
//  WTab.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 16/10/24.
//

import Foundation
import SwiftUI

enum WTab: Int, CaseIterable {
    case coins = 0
    case favorites = 1
    case profile = 2
}

extension WTab {
    var title: String {
        switch self {
        case .coins: return "Coins"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    
    var systemIcon: String {
        switch self {
        case .coins:
            return "bitcoinsign.bank.building"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
}

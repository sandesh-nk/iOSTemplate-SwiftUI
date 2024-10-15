//
//  CoinsModel.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 15/10/24.
//

import Foundation
import Combine

class CoinsModel: ObservableObject {
    private var cancellable: Set<AnyCancellable> = []
    let service = GeckoCoinsService()
    
    @Published var coins: [Coin] = []
    
    func fetchgeckoCoins() async {
        
        print("callint get coins")
        await service.getCoins()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("some eror")
            } receiveValue: { newcoins in
                self.coins = newcoins
            }
            .store(in: &cancellable)
    }
}

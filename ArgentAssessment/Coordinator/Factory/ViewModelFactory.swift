//
//  ViewModelFactory.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 21/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3

protocol ViewModelFactory {
    func makeWalletViewModel(for config: Configuration) -> WalletViewModel?
    func makeEventViewModel(for config: Configuration) -> EventViewModel?
}

extension ViewModelFactory {
    func makeWalletViewModel(for config: Configuration) -> WalletViewModel? {
        guard let storage = AOKeyStorage(),
            let ethClient = EthereumClient(config: config),
            let walletService = WalletApiService(config: config,
                                                 ethClient: ethClient,
                                                 keyStorage: storage) else { return nil }
        
        return WalletViewModel(walletService: walletService,
                               defaultWallet: config.argentAddress,
                               unit: config.ethUnit)
    }
    
    func makeEventViewModel(for config: Configuration) -> EventViewModel? {
        guard let ethClient = EthereumClient(config: config),
            let eventService = EventApiService(config: config,
                                               ethClient: ethClient) else { return nil }
        
        return EventViewModel(eventService: eventService,
                              address: config.argentAddress)
    }
}

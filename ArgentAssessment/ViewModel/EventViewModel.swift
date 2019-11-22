//
//  EventViewModel.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3

class EventViewModel {
    private let defaultWallet: EthereumAddress
    private let eventService: EventService
    private(set) var transfers: [Transfer] = []
    
    init(eventService: EventService, address: EthereumAddress) {
        self.defaultWallet = address
        self.eventService = eventService
    }
    
    func getTransfers(onFinish: @escaping ([Transfer]) -> ()) {
        eventService.getTransferEvents(to: defaultWallet, onSuccess: { [weak self] events in
            guard let self = self else { return }
            self.transfers = events.map {
                Transfer(from: $0.from.value, token: $0.log.address.value, amount: $0.value)
            }
            onFinish(self.transfers)
        }, onFailure: { error in
            // Not enough info - what to do in case of error? ( leave transfers property cached? or reset it with empty array? )
            onFinish([])
        })
    }
}

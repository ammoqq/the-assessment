//
//  EventService.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 20/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3

protocol EventService {
    func getTransferEvents(to address: EthereumAddress, onSuccess: @escaping ([ERC20Events.Transfer])->(), onFailure: @escaping (Error)->())
}

class EventApiService: EventService {
    private let config: Configuration
    private let ethClient: EthereumClient
    
    init?(config: Configuration, ethClient: EthereumClient) {
        self.ethClient = ethClient
        self.config = config
    }
    
    func getTransferEvents(to address: EthereumAddress, onSuccess: @escaping ([ERC20Events.Transfer])->(), onFailure: @escaping (Error)->()) {
        var transferSignature: String
        var encodedAddress: [UInt8]
        do {
            transferSignature = try ERC20Events.Transfer.signature()
            encodedAddress = try ABIEncoder.encode(address)
        } catch let e {
            onFailure(e)
            return
        }
        
        let encodedString = String(hexFromBytes: encodedAddress)
        let topics = [transferSignature, nil, encodedString, nil]
        
        getEvents(addresses: nil, topics: topics, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    private func getEvents(addresses: [String]?, topics: [String?], onSuccess: @escaping ([ERC20Events.Transfer])->(), onFailure: @escaping (Error)->()) {
        ethClient.getEvents(addresses: addresses, topics: topics, fromBlock: .Earliest, toBlock: .Latest, eventTypes: [ERC20Events.Transfer.self]) { (error, events, _) in
            if let events = events as? [ERC20Events.Transfer] {
                onSuccess(events)
            } else {
                onFailure(error ?? EthereumClientError.unexpectedReturnValue)
            }
        }
    }
}

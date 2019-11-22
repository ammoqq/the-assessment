//
//  ServiceMocks.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 20/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import XCTest
@testable import ArgentAssessment
import web3
import BigInt
import Quick
import Nimble

class WalletServiceMock: WalletService {
    func getBalance(address: EthereumAddress, onSuccess: @escaping (BigUInt) -> (), onFailure: @escaping (Error) -> ()) {
        onSuccess(2670000000000000000)
    }
    
    func sendEth(to: EthereumAddress, amount: BigUInt, onSuccess: @escaping (String) -> (), onFailure: @escaping (Error) -> ()) {
        onSuccess("Tx00000000000000000000")
    }
}

class EventServiceMock: EventService {
    func getTransferEvents(to address: EthereumAddress, onSuccess: @escaping ([ERC20Events.Transfer]) -> (), onFailure: @escaping (Error) -> ()) {
        let ethLogData = EthereumLogData()
        let topics = ["0xe41d2489571d322189246dafa5ebde1f4699f498", "0xe81d2489571d322189246dafa5ebde1f4699f498"]
        let data = ["0xe21d2489571d322189246dafa5ebde1f4699f498"]
        let transfers = ethLogData.ethLogs.map { try! ERC20Events.Transfer(topics: topics, data: data, log: $0)! }
        onSuccess(transfers)
    }
}

class EventServiceFailingMock: EventService {
    func getTransferEvents(to address: EthereumAddress, onSuccess: @escaping ([ERC20Events.Transfer]) -> (), onFailure: @escaping (Error) -> ()) {
        onFailure(EthereumClientError.noResultFound)
    }
}

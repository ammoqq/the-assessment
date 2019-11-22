//
//  TransferToken.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 20/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import BigInt
import web3

struct TransferToken: ABIFunction {
    static let name = "transferToken"
    let gasPrice: BigUInt? = BigUInt(38000000000)
    let gasLimit: BigUInt? = BigUInt(250000)
    let contract: EthereumAddress
    let from: EthereumAddress?
    
    let wallet: EthereumAddress
    let token: EthereumAddress
    let to: EthereumAddress
    let amount: BigUInt
    let data: Data
    
    init(transactionData: EthereumTransactionData) {
        contract = transactionData.contract
        wallet = transactionData.wallet
        token = transactionData.ethToken
        to = transactionData.to
        amount = transactionData.amount
        data = transactionData.data
        from = transactionData.from
    }
    
    func encode(to encoder: ABIFunctionEncoder) throws {
        try encoder.encode(wallet)
        try encoder.encode(token)
        try encoder.encode(to)
        try encoder.encode(amount)
        try encoder.encode(data)
    }
}

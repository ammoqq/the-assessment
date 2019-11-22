//
//  EthereumTransactionData.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 20/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import BigInt
import web3

struct EthereumTransactionData {
    let contract: EthereumAddress
    let ethToken: EthereumAddress
    let from: EthereumAddress
    let to: EthereumAddress
    let wallet: EthereumAddress
    let amount: BigUInt
    let data: Data
}

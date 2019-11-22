//
//  EthereumAccount+extensions.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3

extension EthereumAccount {
    var ethereumAddress: EthereumAddress {
        return EthereumAddress(address)
    }
}

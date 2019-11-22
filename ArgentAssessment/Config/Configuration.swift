//
//  Configuration.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3

struct Configuration {
    let nodeAddress = "https://ropsten.infura.io/v3/735489d9f846491faae7a31e1862d24b"
    let contractAddress = EthereumAddress("0xcdAd167a8A9EAd2DECEdA7c8cC908108b0Cc06D1")
    let argentAddress = EthereumAddress("0x70ABd7F0c9Bdc109b579180B272525880Fb7E0cB")
    let ethToken = EthereumAddress("0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")
    let ethUnit = "ETH"
}

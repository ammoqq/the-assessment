//
//  EthereumClient+extensions.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 21/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3

extension EthereumClient {
    convenience init?(config: Configuration) {
        guard let url = URL(string: config.nodeAddress) else { return nil }
        self.init(url: url)
    }
}

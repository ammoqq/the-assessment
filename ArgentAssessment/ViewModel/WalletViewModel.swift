//
//  WalletViewModel.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import BigInt
import web3

class WalletViewModel {
    private let defaultWallet: EthereumAddress
    private let defaultTarget: EthereumAddress
    private let unit: String
    private let walletService: WalletService
    
    init(walletService: WalletService, defaultWallet: EthereumAddress, unit: String) {
        self.walletService = walletService
        self.defaultWallet = defaultWallet
        self.unit = unit
        // This would probably come from some user input normally
        defaultTarget = EthereumAddress("0x95aAcC5B96A096661b30658c4FF10e71E2f32Aad")
    }
    
    func getBalance(onFinish: @escaping (String?) -> ()) {
        walletService.getBalance(address: defaultWallet, onSuccess: { balance in
            onFinish(self.formattedBalance(balance))
        }, onFailure: { error in
            // Lacking info what should we do with the error. I stop propagating it here & unify to 1 closure.
            onFinish(nil)
        })
    }
    
    func sendEth(onFinish: @escaping (String?) -> ()) {
        walletService.sendEth(to: defaultTarget, amount: 10000000000000000, onSuccess: { _ in }, onFailure: { _ in })
    }
    
    func formattedBalance(_ balance: BigUInt) -> String? {
        let dividedBalance = balance / 10000000000000000
        let balanceToDouble = Double(dividedBalance)/100
        return String(format:"%.2f", balanceToDouble) + " " + unit
    }
}

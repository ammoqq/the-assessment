//
//  WalletService.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import web3
import BigInt

protocol WalletService {
    func getBalance(address: EthereumAddress, onSuccess: @escaping (BigUInt)->(), onFailure: @escaping (Error)->())
    func sendEth(to: EthereumAddress, amount: BigUInt, onSuccess: @escaping (String)->(), onFailure: @escaping (Error)->())
}

class WalletApiService: WalletService {
    private let config: Configuration
    private let ethClient: EthereumClientProtocol
    private let keyStorage: EthereumKeyStorageProtocol
    
    init?(config: Configuration, ethClient: EthereumClientProtocol, keyStorage: EthereumKeyStorageProtocol) {
        self.ethClient = ethClient
        self.config = config
        self.keyStorage = keyStorage
    }
    
    func getBalance(address: EthereumAddress, onSuccess: @escaping (BigUInt)->(), onFailure: @escaping (Error)->()) {
        ethClient.eth_getBalance(address: address.value, block: .Latest, completion: { (error, balance) in
            if let balance = balance {
                onSuccess(balance)
            } else if let error = error {
                onFailure(error)
            }
        })
    }
    
    func sendEth(to: EthereumAddress, amount: BigUInt, onSuccess: @escaping (String)->(), onFailure: @escaping (Error)->()) {
        guard let account = try? EthereumAccount(keyStorage: keyStorage) else {
            onFailure(EthereumAccountError.loadAccountError)
            return
        }
        var transaction: EthereumTransaction
        do {
            let function = transfer(from: account.ethereumAddress, to: to, amount: amount)
            transaction = try function.transaction()
        } catch let e {
            onFailure(e)
            return
        }
        
        sendRawTransaction(transaction: transaction, account: account, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    private func sendRawTransaction(transaction: EthereumTransaction, account: EthereumAccount, onSuccess: @escaping (String)->(), onFailure: @escaping (Error)->()) {
        ethClient.eth_sendRawTransaction(transaction, withAccount: account) { (error, txHash) in
            print("TX Hash: \(String(describing: txHash))")
            if let txHash = txHash {
                onSuccess(txHash)
            } else if let error = error {
                onFailure(error)
            }
        }
    }
    
    private func transfer(from: EthereumAddress, to: EthereumAddress, amount: BigUInt, data: Data = Data()) -> TransferToken {
        let transactionData = EthereumTransactionData(contract: config.contractAddress,
                                                      ethToken: config.ethToken,
                                                      from: from,
                                                      to: to,
                                                      wallet: config.argentAddress,
                                                      amount: amount,
                                                      data: data
                                                    )
        return TransferToken(transactionData: transactionData)
    }
}

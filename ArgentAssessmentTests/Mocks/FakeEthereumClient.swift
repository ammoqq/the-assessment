//
//  FakeEthereumClient.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 21/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import BigInt
import web3

class FakeEthereumClient: EthereumClientProtocol {
    let fakeBalance: BigUInt = 4999
    let fakeTransaction = "txHash"
    
    init() {
        // Mock init
    }
    
    required init(url: URL, sessionConfig: URLSessionConfiguration) {
        // Mock method
    }
    
    required init(url: URL) {
        // Mock method
    }
    
    var network: EthereumNetwork?
    
    func net_version(completion: @escaping ((EthereumClientError?, EthereumNetwork?) -> Void)) {
        // Mock method
    }
    
    func eth_gasPrice(completion: @escaping ((EthereumClientError?, BigUInt?) -> Void)) {
        // Mock method
    }
    
    func eth_blockNumber(completion: @escaping ((EthereumClientError?, Int?) -> Void)) {
        // Mock method
    }
    
    func eth_getBalance(address: String, block: EthereumBlock, completion: @escaping ((EthereumClientError?, BigUInt?) -> Void)) {
        completion(nil, fakeBalance)
    }
    
    func eth_getCode(address: String, block: EthereumBlock, completion: @escaping ((EthereumClientError?, String?) -> Void)) {
        // Mock method
    }
    
    func eth_sendRawTransaction(_ transaction: EthereumTransaction, withAccount account: EthereumAccount, completion: @escaping ((EthereumClientError?, String?) -> Void)) {
        completion(nil, fakeTransaction)
    }
    
    func eth_getTransactionCount(address: String, block: EthereumBlock, completion: @escaping ((EthereumClientError?, Int?) -> Void)) {
        // Mock method
    }
    
    func eth_getTransaction(byHash txHash: String, completion: @escaping ((EthereumClientError?, EthereumTransaction?) -> Void)) {
        // Mock method
    }
    
    func eth_getTransactionReceipt(txHash: String, completion: @escaping ((EthereumClientError?, EthereumTransactionReceipt?) -> Void)) {
        // Mock method
    }
    
    func eth_call(_ transaction: EthereumTransaction, block: EthereumBlock, completion: @escaping ((EthereumClientError?, String?) -> Void)) {
        // Mock method
    }
    
    func eth_getLogs(addresses: [String]?, topics: [String?]?, fromBlock: EthereumBlock, toBlock: EthereumBlock, completion: @escaping ((EthereumClientError?, [EthereumLog]?) -> Void)) {
        // Mock method
    }
    
    func eth_getBlockByNumber(_ block: EthereumBlock, completion: @escaping ((EthereumClientError?, EthereumBlockInfo?) -> Void)) {
        // Mock method
    }
}

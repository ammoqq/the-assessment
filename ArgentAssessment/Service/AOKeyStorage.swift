//
//  AOKeyStorage.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import web3

public class AOKeyStorage: EthereumKeyStorageProtocol {
    let keyString = "PK"
    let keychain = KeychainWrapper(serviceName: "eeCE2B59267599974EB2f57Ed5763d5176D1520D")
    
    init?() {
        /*
            Populating with a default private key just for this task,
            as there is no Account creation/retrieval screen included
        */
        let privateKey = "0xec983791a21bea916170ee0aead71ab95c13280656e93ea4124c447bbd9a24a2"
        guard let data = privateKey.hexData else { return nil }
        try? storePrivateKey(key: data)
    }
    
    public func storePrivateKey(key: Data) throws -> Void {
        let success = keychain.set(key, forKey: keyString)
        
        if !success {
            throw EthereumKeyStorageError.failedToSave
        }
    }
    
    public func loadPrivateKey() throws -> Data {
        guard let data = keychain.data(forKey: keyString) else {
            throw EthereumKeyStorageError.failedToLoad
        }
        
        return data
    }
}

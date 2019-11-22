//
//  WalletServiceTests.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 20/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
@testable import ArgentAssessment
import web3
import BigInt
import Quick
import Nimble

class WalletServiceTests: QuickSpec {
    let defaultWallet = EthereumAddress("0xe41d2489571d322189246dafa5ebde1f4699f498")
    var walletService: WalletService?
    
    override func spec() {
        describe("WalletService") {
            context("Given a service implementation") {
                beforeEach {
                    self.walletService = WalletApiService(config: Configuration(), ethClient: FakeEthereumClient(), keyStorage: AOKeyStorage()!)
                }
                it("It should get balance for address") {
                    self.walletService?.getBalance(address: self.defaultWallet, onSuccess: { balance in
                        expect(balance).to(equal(FakeEthereumClient().fakeBalance))
                    }, onFailure: { error in
                        fail()
                    })
                }
                it("It should send ether") {
                    self.walletService?.sendEth(to: self.defaultWallet, amount: 44444, onSuccess: { txHash in
                        expect(txHash).to(equal(FakeEthereumClient().fakeTransaction))
                    }, onFailure: { error in
                        fail()
                    })
                }
                it("It should fail sending ether to wrong address") {
                    self.walletService?.sendEth(to: EthereumAddress("0x0"), amount: 44444, onSuccess: { txHash in
                        fail()
                    }, onFailure: { error in
                        expect(error.localizedDescription).to(equal(web3.ABIError.invalidValue.localizedDescription))
                    })
                }
            }
        }
    }
}

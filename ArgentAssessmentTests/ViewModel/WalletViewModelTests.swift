//
//  WalletViewModelTests.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 18/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import XCTest
@testable import ArgentAssessment
import web3
import BigInt
import Quick
import Nimble


class WalletViewModelTests: QuickSpec {
    var walletVM: WalletViewModel?
    let weiAmount: BigUInt = 4670000000000000000
    let defaultWallet = EthereumAddress("0xe41d2489571d322189246dafa5ebde1f4699f498")
    
    override func spec() {
        describe("A WalletViewModel") {
            context("Given a successful request from service") {
                beforeEach {
                    self.walletVM = WalletViewModel(walletService: WalletServiceMock(), defaultWallet: self.defaultWallet, unit: "ETH")
                }
                it("It should get balance in ETH") {
                    self.walletVM?.getBalance(onFinish: { balance in
                        expect(balance).to(equal("2.67 ETH"))
                    })
                }
                it("It should format balance from wei") {
                    let balance = self.walletVM?.formattedBalance(self.weiAmount)
                    expect(balance).to(equal("4.67 ETH"))
                }
            }
        }
    }
}

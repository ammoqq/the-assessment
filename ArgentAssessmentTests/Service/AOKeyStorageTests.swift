//
//  AOKeyStorageTests.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 20/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import XCTest
@testable import ArgentAssessment
import web3
import BigInt
import Quick
import Nimble


class AOKeyStorageTests: QuickSpec {
    var storage: AOKeyStorage?
    
    override func spec() {
        describe("AOKeyStorage") {
            context("Given populated keychain") {
                beforeEach {
                    self.storage = AOKeyStorage()
                }
                it("It should load private key") {
                    let data = try? self.storage?.loadPrivateKey()
                    expect(data).toNot(beNil())
                }
            }
        }
    }
}

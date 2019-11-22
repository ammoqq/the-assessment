//
//  EventViewModelTests.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 21/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
@testable import ArgentAssessment
@testable import web3
import BigInt
import Quick
import Nimble


class EventViewModelTests: QuickSpec {
    var eventVM: EventViewModel?
    let defaultWallet = EthereumAddress("0xe41d2489571d322189246dafa5ebde1f4699f498")
    
    override func spec() {
        describe("An EventViewModel") {
            context("Given a successful request from service") {
                beforeEach {
                    self.eventVM = EventViewModel(eventService: EventServiceMock(), address: self.defaultWallet)
                }
                it("It should get new transfers") {
                    self.eventVM?.getTransfers(onFinish: { transfers in
                        expect(transfers.count).to(beGreaterThan(0))
                        expect(self.eventVM!.transfers.count).to(equal(transfers.count))
                    })
                }
            }
            context("Given a failed request from service") {
                beforeEach {
                    self.eventVM = EventViewModel(eventService: EventServiceFailingMock(), address: self.defaultWallet)
                }
                it("It should get empty transfers") {
                    self.eventVM?.getTransfers(onFinish: { transfers in
                        expect(transfers.count).to(equal(0))
                    })
                }
            }
        }
    }
}

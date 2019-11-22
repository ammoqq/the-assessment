//
//  CoordinatorTests.swift
//  ArgentAssessmentTests
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import XCTest
@testable import ArgentAssessment
import web3
import BigInt
import Quick
import Nimble

// Integration tests for the coordinator
class CoordinatorTests: QuickSpec {
    var coordinator: Coordinator?

    override func spec() {
        describe("A Coordinator") {
            context("Given a configuration") {
                beforeEach {
                    self.coordinator = Coordinator(configuration: Configuration())
                }
                it("It should provide initial view controller as navigationController") {
                    let initialVC = self.coordinator?.initialViewController()
                    expect(initialVC).to(beAKindOf(UINavigationController.self))
                }
                it("It should provide event view controller") {
                    let eventVC = self.coordinator?.eventViewController()
                    expect(eventVC).to(beAKindOf(EventViewController.self))
                }
            }
        }
    }
}

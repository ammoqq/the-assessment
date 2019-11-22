//
//  Coordinator.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 18/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import UIKit
import web3

typealias Callback = () -> ()

class Coordinator: ViewModelFactory {
    private let configuration: Configuration
    private var navigationController: UINavigationController?
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func initialViewController() -> UIViewController? {
        guard let walletViewModel = makeWalletViewModel(for: configuration) else { return nil }
        
        let walletViewController = WalletViewController(walletViewModel: walletViewModel)
        walletViewController.didTapViewTransfers = { [weak self] in
            guard let eventViewController = self?.eventViewController() else { return }
            self?.navigationController?.pushViewController(eventViewController, animated: true)
        }
        navigationController = UINavigationController(rootViewController: walletViewController)
        return navigationController
    }
    
    func eventViewController() -> EventViewController? {
        guard let eventViewModel = makeEventViewModel(for: configuration) else { return nil }
        return EventViewController(eventViewModel: eventViewModel)
    }
}

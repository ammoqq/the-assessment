//
//  WalletViewController.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 18/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class WalletViewController: UIViewController {
    var didTapViewTransfers: Callback?
    private let walletViewModel: WalletViewModel
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wallet Balance"
        label.font = .systemFont(ofSize: 36)
        return label
    }()
    
    lazy private var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00 ETH"
        label.font = .systemFont(ofSize: 42)
        return label
    }()
    
    lazy private var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send 0.01 ETH", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        return button
    }()
    
    lazy private var viewTransfersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View ERC20 Transfers", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26)
        return button
    }()
    
    init(walletViewModel: WalletViewModel) {
        self.walletViewModel = walletViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = nil
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletViewModel.getBalance() { [weak self] balance in
            self?.update(balance: balance)
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(balanceLabel)
        view.addSubview(sendButton)
        view.addSubview(viewTransfersButton)
        
        let margin: CGFloat = 100
        let labelSpacing: CGFloat = 10
        let buttonSize = CGSize(width: 250, height: 50)
        
        titleLabel.easy.layout(Top(margin), CenterX())
        balanceLabel.easy.layout(Top(labelSpacing).to(titleLabel, .bottom), CenterX())
        sendButton.easy.layout(Top(labelSpacing).to(balanceLabel), Size(buttonSize), CenterX())
        sendButton.addTarget(self, action: #selector(sendEthTapped), for: .touchUpInside)
        
        viewTransfersButton.easy.layout(Bottom(margin), Size(buttonSize), CenterX())
        viewTransfersButton.addTarget(self, action: #selector(viewTransfersTapped), for: .touchUpInside)
    }
    
    func update(balance: String?) {
        guard let balance = balance else { return }
        DispatchQueue.main.async {
            self.balanceLabel.text = balance
        }
    }
    
    @objc
    func sendEthTapped() {
        walletViewModel.sendEth() { _ in }
    }
    
    @objc
    func viewTransfersTapped() {
        didTapViewTransfers?()
    }
}

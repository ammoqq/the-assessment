//
//  EventViewController.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 18/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class EventViewController: UIViewController {
    private let navigationBarTitle = "ERC20 Transfers"
    private let tableView = UITableView()
    private let eventViewModel: EventViewModel
    
    init(eventViewModel: EventViewModel) {
        self.eventViewModel = eventViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.title = navigationBarTitle
        navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventViewModel.getTransfers() { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransferCell.self, forCellReuseIdentifier: TransferCell.identifier)
        
        view.addSubview(tableView)
        tableView.easy.layout(Edges())
    }
}

extension EventViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventViewModel.transfers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransferCell.identifier) as? TransferCell else {
            return UITableViewCell()
        }
        
        cell.configure(transfer: eventViewModel.transfers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransferCell.preferredHeight
    }
}

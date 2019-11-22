//
//  TransferCell.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class TransferCell: UITableViewCell {
    static let preferredHeight: CGFloat = 100
    private let labelFontSize: CGFloat = 18
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: labelFontSize)
        return label
    }()
    
    lazy var midLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: labelFontSize)
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: labelFontSize)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(topLabel)
        addSubview(midLabel)
        addSubview(bottomLabel)
        
        let marginSpacing: CGFloat = 5
        
        topLabel.easy.layout(TopMargin(marginSpacing), LeftMargin(), RightMargin())
        midLabel.easy.layout(CenterY(), LeftMargin(), RightMargin())
        bottomLabel.easy.layout(BottomMargin(marginSpacing), LeftMargin(), RightMargin())
    }
    
    /*
        Passing model object here, as it is a simple struct without any db model inheritance or any functions.
        In case we'd be dealing with db model, I'd probably generate some simple struct representation of it,
        before passing it to a cell.
    */
    func configure(transfer: Transfer) {
        topLabel.text = "From: \(transfer.from)"
        midLabel.text = "Token: \(transfer.token)"
        bottomLabel.text = "Amount: \(transfer.amount)"
    }
}

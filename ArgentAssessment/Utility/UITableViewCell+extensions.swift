//
//  UITableViewCell+extensions.swift
//  ArgentAssessment
//
//  Created by Artur Osinski on 19/11/2019.
//  Copyright © 2019 Artur Osinski. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

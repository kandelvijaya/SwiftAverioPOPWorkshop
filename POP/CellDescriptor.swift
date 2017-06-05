//
//  CellDescriptor.swift
//  POP
//
//  Created by Vijaya Prakash Kandel on 02.06.17.
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit


protocol CellDescriptor: class {
    static var reuseIdentifier: String { get }
}

extension CellDescriptor where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

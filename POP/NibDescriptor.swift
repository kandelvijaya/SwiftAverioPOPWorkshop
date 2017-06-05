//
//  NibDescriptor.swift
//  POP
//
//  Created by Vijaya Prakash Kandel on 02.06.17.
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

protocol NibDescriptor: class {
    static var nibName: String { get }
}

extension NibDescriptor where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

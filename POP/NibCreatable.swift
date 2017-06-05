//
//  NibCreatable.swift
//  POP
//
//  Created by Vijaya Prakash Kandel on 02.06.17.
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

protocol NibCretable:class {
    static func create() -> Self
}

extension NibCretable where Self: UIView, Self: NibDescriptor {
    static func create() -> Self {
        let nib = UINib(nibName: nibName, bundle: Bundle(for: self))
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}



//
//  ReuseIdentifiable.swift
//  POP
//
//  Created by Vijaya Prakash Kandel on 29.05.17.
//  Copyright © 2017 zalando. All rights reserved.
//

import Foundation


protocol ReuseIdentifiable { }


extension ReuseIdentifiable {

    static var identifier: String {
        return String(describing: self)
    }

}

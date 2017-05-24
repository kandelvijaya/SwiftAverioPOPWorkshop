//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class HeaderView: UIView {

    static func create() -> UIView {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        return nib.instantiate(withOwner: nil, options: nil).first as! UIView
    }

}

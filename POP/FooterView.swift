//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class FooterView: UIView {

    static func create() -> FooterView {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        return nib.instantiate(withOwner: nil, options: nil).first as! FooterView
    }

    var onTapBlock : (() -> Void)?

    @IBAction func onTap(_ sender: Any) {
        onTapBlock?()
    }

}

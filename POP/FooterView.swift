//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class FooterView: UIView {

    var onTapBlock : (() -> Void)?

    @IBAction func onTap(_ sender: Any) {
        onTapBlock?()
    }

}


extension FooterView: NibCretable, NibDescriptor { }

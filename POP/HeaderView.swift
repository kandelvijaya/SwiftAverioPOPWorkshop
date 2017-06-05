//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class HeaderView: UIView {
}

extension HeaderView: NibCretable, NibDescriptor {

    static var nibName: String {
        return "SomeHeaderView"
    }

}

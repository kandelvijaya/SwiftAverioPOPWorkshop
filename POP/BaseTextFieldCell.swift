//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

/**
 This is base text field cell in the app.
 */
class BaseUserTextFieldCell: UITableViewCell {

    var dataModel: FormFieldDataModel?

    @IBOutlet weak var detailsTextField: UITextField?

    func setupFormField(with data: FormFieldDataModel) {
        self.dataModel = data
        self.detailsTextField?.text = data.placeholderText
    }

    /// Assuem you have other logic such as
    /// input validation
    /// error reporting
    /// cell setup

}


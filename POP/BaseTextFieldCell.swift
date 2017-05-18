//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

struct FormFieldDataModel {

    var placeholderText: String

}

class BaseUserTextFieldCell: UITableViewCell {

    var dataModel: FormFieldDataModel?

    @IBOutlet weak var detailsTextField: UITextField?

    func setupFormField(with data: FormFieldDataModel) {
        self.dataModel = data
        self.detailsTextField?.text = data.placeholderText
    }

}


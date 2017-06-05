//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class UserDetailTextFieldCell: BaseUserTextFieldCell {

    @IBOutlet weak var iconViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellHeaderLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView?
    var inputFieldBottomBorder: UIView?
    var iconImageName: (normal: String, highlighted: String)?

    lazy var inputField: UITextField! = {
        self.detailsTextField
    } ()

    override func setupFormField(with data: FormFieldDataModel) {
        super.setupFormField(with: data)
        inputField.placeholder = data.placeholderText
        setupCell()
    }

    fileprivate func setupCell() {
        setupIcon()
        inputField.delegate = self
        inputField.autocapitalizationType = .words
        customizeCell()
    }

    private func setupIcon() {
        //TODO:
    }

}

extension UserDetailTextFieldCell: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        applyEnabledVisualStyle()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        applyDisabledVisualStyle()
        return true
    }
    
}


extension UserDetailTextFieldCell: TextFieldAnimator { }

extension UserDetailTextFieldCell: NibDescriptor { }

extension UserDetailTextFieldCell: CellDescriptor { }

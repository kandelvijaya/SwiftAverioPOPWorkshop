//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class UserDetailPasswordCell: BaseUserTextFieldCell {

    @IBOutlet weak var cellHeaderLabel: UILabel!
    var inputFieldBottomBorder: UIView?
    var iconImageName: (normal: String, highlighted: String)?

    lazy var inputField: UITextField! = {
        self.detailsTextField
    }()

    override func setupFormField(with data: FormFieldDataModel) {
        super.setupFormField(with: data)
        inputField.placeholder = data.placeholderText
        setupCell()
    }

    @IBAction func togglePassword(_ sender: UISwitch) {
        inputField.isSecureTextEntry = !sender.isOn
    }

    fileprivate func setupCell() {
        setupIcon()
        inputField.delegate = self
        inputField.autocapitalizationType = .none
        customizeCell()
    }

    private func setupIcon() {
        //TODO:
    }

}

extension UserDetailPasswordCell: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        applyEnabledVisualStyle()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        applyDisabledVisualStyle()
        return true
    }

}

extension UserDetailPasswordCell: TextFieldAnimator { }

extension UserDetailPasswordCell: NibDescriptor { }

extension UserDetailPasswordCell: CellDescriptor { }

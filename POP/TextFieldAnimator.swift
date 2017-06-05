//
//  TextFieldAnimator.swift
//  POP
//
//  Created by Vijaya Prakash Kandel on 02.06.17.
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

protocol TextFieldAnimator: class {
    var cellHeaderLabel: UILabel! { get }
    var inputFieldBottomBorder: UIView? { get set }
    var iconImageName: (normal: String, highlighted: String)? { get }
    var inputField: UITextField! { get }
    var detailsTextField: UITextField? { get }
    var dataModel: FormFieldDataModel? { get }
}

extension TextFieldAnimator where Self: UITableViewCell {
    func customizeCell() {
        separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
        backgroundColor = UIColor.clear
        cellHeaderLabel.text = inputField.placeholder?.uppercased()
        addLineToTextFieldBottom()
        cellHeaderLabel.isHidden = true
        applyDisabledVisualStyle()
    }

    fileprivate func addLineToTextFieldBottom() {
        inputFieldBottomBorder = inputFieldBottomBorder ?? UIView()
        let line = inputFieldBottomBorder!
        inputField.addSubview(line)

        line.translatesAutoresizingMaskIntoConstraints = false
        let trailingSpace: CGFloat = -8
        let heightCons = NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1)
        let leadingCons = NSLayoutConstraint(item: line, attribute: .leading, relatedBy: .equal, toItem: inputField, attribute: .leading, multiplier: 1, constant: 0)
        let trailingCons = NSLayoutConstraint(item: line, attribute: .trailing, relatedBy: .equal, toItem: inputField, attribute: .trailing, multiplier: 1, constant: trailingSpace)
        let yCons = NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: inputField, attribute: .bottom, multiplier: 1, constant: 0)
        inputField.addConstraints([leadingCons, trailingCons, heightCons, yCons])
    }

    func applyEnabledVisualStyle() {
        inputFieldBottomBorder?.backgroundColor = .orange
        cellHeaderLabel.textColor = .orange
        inputField.placeholder = nil
        toggleHeaderLabelVisibility()
    }

    func applyDisabledVisualStyle() {
        inputFieldBottomBorder?.backgroundColor = .black
        cellHeaderLabel.textColor = .gray
        inputField.placeholder = dataModel?.placeholderText
        toggleHeaderLabelVisibility(false)
    }

    private func toggleHeaderLabelVisibility(_ isVisible: Bool = true) {
        if let text = inputField.text, !text.isEmpty {
            showHeaderLabel(animated: false)
        } else if cellHeaderLabel.isHidden && isVisible {
            showHeaderLabel(animated: true)
        } else {
            cellHeaderLabel.isHidden = true
        }
    }

    private func prepareHeaderLabelForAnimation() {
        cellHeaderLabel.alpha = 0
        cellHeaderLabel.isHidden = false
        cellHeaderLabel.frame = headerLabelFrame(animated: false)
    }

    private func showHeaderLabel(animated isAnimated: Bool) {
        prepareHeaderLabelForAnimation()
        UIView.animate(withDuration: animationDuration(animated: isAnimated), animations: {
            self.cellHeaderLabel.frame = self.headerLabelFrame(animated: true)
            self.cellHeaderLabel.alpha = 1
        })
    }

    private func animationDuration(animated: Bool) -> Double {
        return animated ? 0.3: 0
    }

    private func headerLabelFrame(animated: Bool) -> CGRect {
        let yOffset: CGFloat = 15
        return cellHeaderLabel.frame.offsetBy(dx: 0, dy: animated ? yOffset * -1: yOffset)
    }
}

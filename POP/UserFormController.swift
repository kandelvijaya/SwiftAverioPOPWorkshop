//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class UserFormController: UITableViewController {

    lazy var models: [FormFieldDataModel] = {
        let item1 = FormFieldDataModel(placeholderText: "First Name")
        let item2 = FormFieldDataModel(placeholderText: "Password")
        return [item1, item2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }

    private func registerCells() {
        tableView.register(cell: UserDetailTextFieldCell.self)
        tableView.register(cell: UserDetailPasswordCell.self)
    }

}

extension UITableView {

    func register<T>(cell: T.Type) where T: UITableViewCell, T: NibDescriptor, T: CellDescriptor {
        let nib2 = UINib(nibName: T.nibName, bundle: nil)
        register(nib2, forCellReuseIdentifier: T.reuseIdentifier)
    }
}


//MARK:- Delegates
extension UserFormController {

    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView.create()
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView.create()

        footer.onTapBlock = { [weak self] in
            self?.performSegue(withIdentifier: "next", sender: self)
        }
        return footer
    }

}

//MARK:- DataSource
extension UserFormController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let currentModel = models[indexPath.row]

        //Configure
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTextFieldCell.reuseIdentifier)!
            (cell as? UserDetailTextFieldCell)?.setupFormField(with: currentModel)
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: UserDetailPasswordCell.reuseIdentifier)!
            (cell as? UserDetailPasswordCell)?.setupFormField(with: currentModel)
        }

        return cell
    }

}

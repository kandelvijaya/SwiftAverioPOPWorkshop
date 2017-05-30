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

    fileprivate struct CellIds {
        static let detailCell = "UserDetailTextFieldCell"
        static let passwordCell = "UserDetailPasswordCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }

    private func registerCells() {
        let nib = UINib(nibName: "UserDetailTextFieldCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellIds.detailCell)

        let nib2 = UINib(nibName: "UserDetailPasswordCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: CellIds.passwordCell)
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
        return FooterView.create()
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
            cell = tableView.dequeueReusableCell(withIdentifier: CellIds.detailCell)!
            (cell as? UserDetailTextFieldCell)?.setupFormField(with: currentModel)
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: CellIds.passwordCell)!
            (cell as? UserDetailPasswordCell)?.setupFormField(with: currentModel)
        }

        return cell
    }

}

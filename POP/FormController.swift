//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class FormController: UITableViewController {

    lazy var models: [FormFieldDataModel] = {
        let item1 = FormFieldDataModel(placeholderText: "First Name")
        let item2 = FormFieldDataModel(placeholderText: "Password")
        return [item1, item2]
    }()

    fileprivate struct CellIds {
        static let detailCell = "detailTextFieldCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()

        //stop tableview show emty cells below
        tableView.tableFooterView = UIView()
    }

    private func registerCells() {
        let nib = UINib(nibName: "UserDetailsAdvancedTextFieldCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellIds.detailCell)
    }

}


//MARK:- Delegates
extension FormController {


}

//MARK:- DataSource
extension FormController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.detailCell)!
        //Configure
        let currentModel = models[indexPath.row]
        (cell as! UserDetailTextFieldCell).setupFormField(with: currentModel)

        return cell
    }

}

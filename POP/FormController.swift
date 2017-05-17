//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class FormController: UITableViewController {

    fileprivate struct CellIds {
        static let detailCell = "detailTextFieldCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
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
        let model = FormFieldDataModel(text: "hello there")
        (cell as! UserDetailTextFieldCell).setupFormField(with: model)

        return cell
    }

}

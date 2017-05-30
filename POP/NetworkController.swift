//
//  Copyright © 2017 zalando. All rights reserved.
//

import UIKit

final class NetworkController: UIViewController {

    private let api: APIServiceProtocol = APIService()

    @IBOutlet weak var pathOutputLabel: UILabel!

    @IBAction func randomJokeTapped(_ sender: Any) {
        api.get(path: "random") { [weak self] result in
            self?.updateLabel(with: result)
        }
    }

    @IBAction func randomCategoryJokeTapped(_ sender: Any) {
        api.get(path: "funny") { [weak self] result in
            self?.updateLabel(with: result)
        }
    }

    private func updateLabel(with result: NetworkResult<APIResultValueType>) {
        switch result {
        case .error(let e):
            pathOutputLabel.text = e.localizedDescription
            pathOutputLabel.textColor = .red
        case .success(let v):
            pathOutputLabel.textColor = .black
            pathOutputLabel.text = v["value"] as? String ?? "-"
        }
    }

}


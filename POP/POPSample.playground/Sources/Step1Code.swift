import Foundation

// Code snippet that will be used in this workshop

//1. This is the animation code that is duplicated.

/*
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
*/










//2. Protocol Requirements for TextFieldAnimator
/*

 var cellHeaderLabel: UILabel! { get }
 var inputFieldBottomBorder: UIView? { get set }
 var iconImageName: (normal: String, highlighted: String)? { get }
 var inputField: UITextField! { get }
 var detailsTextField: UITextField? { get }
 var dataModel: FormFieldDataModel? { get }

 */




//3. UIView creation
// Lets extract this
/*
class CreatableView: UIView {

    class func create() -> UIView {
        let nib = UINib(nibName: String(describing: Self), bundle: Bundle(for: self as! AnyClass))
        return nib.instantiate(withOwner: nil, options: nil).first as! UIView
    }

}


extension UIView {

    static func create() -> UIView {
        let nib = UINib(nibName: String(describing: Self), bundle: Bundle(for: self as! AnyClass))
        return nib.instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
}
*/





// Both of these have limitation, lets try protocol
// Lets extract the duplicated code to a ptocol extension
/*

 protocol Creatable { }

 extension Creatable {
    static func create() -> UIView {
        let nib = UINib(nibName: String(describing: Self), bundle: Bundle(for: self as! AnyClass))
        return nib.instantiate(withOwner: nil, options: nil).first as! UIView
    }
 }

 */



//4. The above solution works but it requires
// convention that the associated nib file for the uiview uses the same name
// as the class. Can we constrain this implicit convention.
/*
extension Creatable where Self: NibDescriptor {

    static func create() -> UIView {
        let nib = UINib(nibName: nibName, bundle: Bundle(for: self as! AnyClass))
        return nib.instantiate(withOwner: nil, options: nil).first as! UIView
    }

}


// Describes the nib name of the view.
// If the requirement is not implemented then
// Nibname is the same as the name of the class
protocol NibDescriptor {
    static var nibName: String { get }
}


// Statically dispatched
// Consulted second to requirement hook
extension NibDescriptor {

    static var nibName: String {
        return String(describing: self)
    }
    
}
*/


// Step 5: Nice!
// Lets combine this knowledge to TableViewController
// Can we get rid of this duplication
/*
private func registerCells() {
    let nib = UINib(nibName: UserDetailTextFieldCell.nibName, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "UserDetailTextFieldCell")

    let nib2 = UINib(nibName: UserDetailPasswordCell.nibName, bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: "UserDetailPasswordCell")
}
*/

// nibName in cells just by declaring 
/*
 extension UserDetailTextFieldCell: NibDescriptor { }
 extension UserDetailPasswordCell: NibDescriptor { }
 */


// Can we do the same for reuseIdentifier. 
/*
protocol ReuseIdentifiable { }


extension ReuseIdentifiable {

    static var identifier: String {
        return String(describing: self)
    }
    
}
 */

// Question: What is reason for not having a requirement or customization point?


//Step 6:
//Lets check our registerCells
// We got rid of stringly typed identifier
// What if we have 6 different cells, will we be repeating these 2 lines for 6 times. 
// Lets generalize them.
/*
private func registerCells() {
    let nib = UINib(nibName: UserDetailTextFieldCell.nibName, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: UserDetailTextFieldCell.identifier)

    let nib2 = UINib(nibName: UserDetailPasswordCell.nibName, bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: UserDetailPasswordCell.identifier)
}
 */



//Step 7:
// A utility method that registers using generics
/*
func register<T>(_ cell: T.Type) where T: NibDescriptor, T: ReuseIdentifiable, T: UITableViewCell {
    let nib = UINib(nibName: cell.nibName, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cell.identifier)
}
*/

// Discuss what are the limitation of this approach. 


// Step 8: 
// Retroactivelly modelling for all tableview when its a nice addtion
/*
extension UITableView {
    func register<T>(_ cell: T.Type) where T: NibDescriptor, T: ReuseIdentifiable, T: UITableViewCell {
        let nib = UINib(nibName: cell.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
}
*/


// The call site now becomes much more stronly typed and concise and readable
/*
tableView.register(UserDetailTextFieldCell.self)
tableView.register(UserDetailPasswordCell.self)
*/


// Step 9: Lets do the same for Deque. Its not a must be a nice to have feature.
/*
extension UITableView {

    func register<T>(_ cell: T.Type) where T: NibDescriptor, T: ReuseIdentifiable, T: UITableViewCell {
        let nib = UINib(nibName: cell.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }


    func deque<T>(at indexPath: IndexPath) -> T?  where T: ReuseIdentifiable, T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
    
}
 */

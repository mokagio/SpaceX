import UIKit

extension NSLayoutConstraint {

    convenience init(making attribute: NSLayoutConstraint.Attribute, of view1: Any, equalTo view2: Any) {
        self.init(
            item: view1,
            attribute: attribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: view2,
            attribute: attribute,
            multiplier: 1,
            constant: 0
        )
    }
}

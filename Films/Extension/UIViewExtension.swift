import UIKit

extension UIView {
    static func fromNib() -> Self? {
        let nibView = Bundle.main.loadNibNamed(String(describing: self),
                                               owner: nil,
                                               options: nil)?.first
        let view = nibView >> self
        return view
    }
}

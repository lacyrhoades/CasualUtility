import UIKit

extension UIView {
    public func addAutoSubview(_ view: UIView?) {
        guard let view = view else {
            return
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    public func border(_ width: CGFloat, _ color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}


extension UIStackView {
    public func addAutoArrangedSubview(_ view: UIView?) {
        guard let view = view else {
            return
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(view)
    }
}

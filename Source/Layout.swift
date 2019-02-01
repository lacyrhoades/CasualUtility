import UIKit

public struct Layout {
    public static func doNotCompress(_ view: UIView, onAxis axis: NSLayoutConstraint.Axis) {
        view.setContentCompressionResistancePriority(UILayoutPriority.required, for: axis)
    }
    
    @discardableResult public static func pinHorizontal(_ view: UIView) -> [NSLayoutConstraint] {
        return Layout.pinHorizontal(view, withMargins: 0)
    }
    
    @discardableResult public static func pinHorizontal(_ view: UIView, withMargins margin: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-margin-[view]-margin-|",
            options: [], metrics: ["margin": margin], views: ["view": view]
        )
        view.superview!.addConstraints(
            constraints
        )
        return constraints
    }
    
    @discardableResult public static func pinVertical(_ view: UIView, withMargins margin: CGFloat, withPriorityString priority: String = "1000") -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(margin@priority)-[view]-(margin@priority)-|",
            options: [], metrics: ["margin": margin, "priority": priority], views: ["view": view]
        )
        view.superview!.addConstraints(
            constraints
        )
        return constraints
    }
    
    @discardableResult public static func pinVertical(_ view: UIView) -> [NSLayoutConstraint] {
        return Layout.pinVertical(view, withMargins: 0)
    }
    
    public static func pinToTop(_ view: UIView) {
        view.superview!.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[view]",
                options: [], metrics: [:], views: ["view": view])
        )
    }
    
    @discardableResult public static func pinTop(_ view: UIView, byAmount amt: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview!, attribute: .top, multiplier: 1, constant: amt)
        view.superview!.addConstraint(
            constraint
        )
        return constraint
    }
    
    @discardableResult public static func pinTopMargin(_ view: UIView, byAmount amt: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview!, attribute: .topMargin, multiplier: 1, constant: amt)
        view.superview!.addConstraint(
            constraint
        )
        return constraint
    }
    
    @discardableResult public static func pinTrailing(_ view: UIView, byAmount amt: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: view.superview!, attribute: .trailing, multiplier: 1, constant: -1 * amt)
        view.superview!.addConstraint(
            constraint
        )
        return constraint
    }
    
    @discardableResult public static func pinTrailing(_ view: UIView, withMultiplier mult: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: view.superview!, attribute: .trailing, multiplier: mult, constant: 0)
        view.superview!.addConstraint(
            constraint
        )
        return constraint
    }

    
    @discardableResult public static func pinBottom(_ view: UIView, byAmount amt: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: view.superview!, attribute: .bottom, multiplier: 1, constant: -1 * amt)
        
        view.superview!.addConstraint(
            constraint
        )
        
        return constraint
    }
    
    public static func pinLeading(_ view: UIView, byAmount amt: CGFloat) {
        view.superview!.addConstraint(
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: view.superview!, attribute: .leading, multiplier: 1, constant: amt)
        )
    }
    
    public static func pinToBottom(_ view: UIView) {
        view.superview!.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[view]|",
                options: [], metrics: [:], views: ["view": view])
        )
    }
    
    public static func pinVertical(_ layout: String, withViews views: [String: AnyObject]) {
        (views.first!.1 as! UIView).superview!.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: layout, options: [], metrics: [:], views: views
            )
        )
    }
    
    public static func pinVertical(_ layout: String, withViews views: [String: AnyObject], andMetrics metrics: [String: CGFloat]) {
        (views.first!.1 as! UIView).superview!.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: layout, options: [], metrics: metrics, views: views
            )
        )
    }
    
    public static func pinLayout(_ layout: String, withViews views: [String: AnyObject], andMetrics metrics: [String: CGFloat]) {
        (views.first!.1 as! UIView).superview!.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: layout, options: [], metrics: metrics, views: views
            )
        )
    }
    
    @discardableResult public static func pin(topOf bottomView: UIView, toBottomOf topView: UIView) -> NSLayoutConstraint {
        return self.pin(topOf: bottomView, toBottomOf: topView, withSpace: 0)
    }
    
    @discardableResult public static func pin(topOf bottomView: UIView, toBottomOf topView: UIView, withSpace space: CGFloat) -> NSLayoutConstraint {
        return self.pin(topOf: bottomView, toBottomOf: topView, inView: topView.superview!, withSpace: space, withPriority: UILayoutPriority.required)
    }
    
    @discardableResult public static func pin(topOf bottomView: UIView, toBottomOf topView: UIView, inView: UIView, withSpace space: CGFloat) -> NSLayoutConstraint {
        return self.pin(topOf: bottomView, toBottomOf: topView, inView: inView, withSpace: space, withPriority: UILayoutPriority.required)
    }
    
    @discardableResult public static func pin(topOf bottomView: UIView, toBottomOf topView: UIView, inView: UIView, withSpace space: CGFloat, withPriority priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: bottomView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: space)
        constraint.priority = priority
        inView.addConstraint(constraint)
        return constraint
    }
    
    public static func pin(bottomOf view: UIView, toBottomOf otherView: UIView, inView: UIView) {
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: otherView, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    @discardableResult public static func pinHorizontal(_ view: UIView, withRelativeMargins margin: CGFloat) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        let superview = view.superview!
        constraints.append(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: margin, constant: 0))
        constraints.append(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1 - margin, constant: 0))
        superview.addConstraints(constraints)
        return constraints
    }
    
    public static func pinHorizontalSides(of ofView: UIView, to toView: UIView, in inView: UIView, withSpace space: CGFloat) {
        inView.addConstraints([
            NSLayoutConstraint(item: ofView, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1, constant: space),
            NSLayoutConstraint(item: ofView, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1, constant: -1 * space)
            ])
    }
    
    @discardableResult public static func pinAllSides(of ofView: UIView) -> [NSLayoutConstraint] {
        return Layout.pinAllSides(of: ofView, to: ofView.superview!, in: ofView.superview!)
    }
    
    @discardableResult public static func pinAllSides(of ofView: UIView, to toView: UIView, in inView: UIView) -> [NSLayoutConstraint] {
        return Layout.pinAllSides(of: ofView, to: toView, in: inView, withMargins: 0)
    }
    
    @discardableResult public static func pinAllSides(of ofView: UIView, to toView: UIView, in inView: UIView, withMargins margin: CGFloat) -> [NSLayoutConstraint] {
        return Layout.pinAllSides(of: ofView, to: toView, in: inView, withMargins: margin, withPriority: .required)
    }
    
    @discardableResult public static func pinAllSides(of ofView: UIView, to toView: UIView, in inView: UIView, withMargins margin: CGFloat, withPriority priority: UILayoutPriority) -> [NSLayoutConstraint] {
        let constraints = [
            NSLayoutConstraint(item: ofView, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1, constant: -1 * margin),
            NSLayoutConstraint(item: ofView, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1, constant: margin),
            NSLayoutConstraint(item: ofView, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1, constant: -1 * margin),
            NSLayoutConstraint(item: ofView, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1, constant: margin)
        ]
        for constraint in constraints {
            constraint.priority = priority
        }
        inView.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult public static func pinAllMargins(of ofView: UIView, to toView: UIView, in inView: UIView) -> [NSLayoutConstraint] {
        let constraints = [
            NSLayoutConstraint(item: ofView, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .topMargin, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: ofView, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottomMargin, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: ofView, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leadingMargin, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: ofView, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailingMargin, multiplier: 1, constant: 0)
        ]
        inView.addConstraints(constraints)
        return constraints
    }
    
    public static func pinBaselines(of ofView: UIView, to toView: UIView, in inView: UIView, by yOffset: CGFloat) {
        inView.addConstraint(NSLayoutConstraint(item: ofView, attribute: .firstBaseline, relatedBy: .equal, toItem: toView, attribute: .firstBaseline, multiplier: 1, constant: yOffset))
    }
    
    public static func pinCenter(of ofView: UIView, to toView: UIView, in inView: UIView, by yOffset: CGFloat) {
        inView.addConstraint(NSLayoutConstraint(item: ofView, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1, constant: yOffset))
    }
    
    public static func pinBottom(of ofView: UIView, to toView: UIView, in inView: UIView, by yOffset: CGFloat) {
        inView.addConstraint(NSLayoutConstraint(item: ofView, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1, constant: -1 * yOffset))
    }
    
    public static func verticallyPin(view: UIView, toCenterOf otherView: UIView, withYOffset offset: CGFloat, inView: UIView) {
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: otherView, attribute: .centerY, multiplier: 1, constant: offset))
    }
    
    public static func horizontallyPin(view: UIView, toCenterOf otherView: UIView, withXOffset offset: CGFloat, inView: UIView) {
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: otherView, attribute: .centerX, multiplier: 1, constant: offset))
    }
    
    @discardableResult public static func setHeight(of: UIView, to: CGFloat, withPriority priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: of, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: to)
        constraint.priority = priority
        of.superview!.addConstraint(
            constraint
        )
        return constraint
    }
    
    @discardableResult public static func setWidth(of: UIView, to: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: of, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: to)
        of.superview!.addConstraint(
            constraint
        )
        return constraint
    }
    
    @discardableResult public static func matchMaxHeight(ofView: UIView, toView: UIView, inView: UIView, byFactorOf multiplier: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: ofView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: toView, attribute: .height, multiplier: multiplier, constant: 0)
        inView.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func matchMaxWidth(ofView: UIView, toView: UIView, inView: UIView, byFactorOf multiplier: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: ofView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: toView, attribute: .width, multiplier: multiplier, constant: 0)
        inView.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func matchWidth(ofView: UIView, toView: UIView, inView: UIView, byFactorOf multiplier: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: ofView, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: multiplier, constant: 0)
        inView.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func matchHeight(ofView: UIView, toView: UIView, inView: UIView, byFactorOf multiplier: CGFloat) -> NSLayoutConstraint {
        return Layout.matchHeight(ofView: ofView, toView: toView, inView: inView, byFactorOf: multiplier, withPriority: UILayoutPriority.required)
    }
    
    @discardableResult public static func matchHeight(ofView: UIView, toView: UIView, inView: UIView, byFactorOf multiplier: CGFloat, withPriority priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: ofView, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: multiplier, constant: 0)
        constraint.priority = priority
        inView.addConstraint(constraint)
        return constraint
    }
    
    public static func square(_ view: UIView, toSize size: CGFloat) {
        view.superview!.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size))
        view.superview!.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size))
    }

    @discardableResult public static func squareUp(view: UIView, inView: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        inView.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func setRatio(ofView view: UIView, inView: UIView, withWidthToHeightRatio ratio: CGFloat, withPriority priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: ratio, constant: 0)
        constraint.priority = priority
        inView.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func centerX(_ view: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview!, attribute: .centerX, multiplier: 1, constant: 0)
        view.superview!.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func centerY(_ view: UIView, multiplier: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview!, attribute: .centerY, multiplier: multiplier, constant: 0)
        view.superview!.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func centerY(_ view: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview!, attribute: .centerY, multiplier: 1, constant: 0)
        view.superview!.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func centerY(_ view: UIView, offsetBy offset: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview!, attribute: .centerY, multiplier: 1, constant: offset)
        view.superview!.addConstraint(constraint)
        return constraint
    }
    
    public static func pin(leading: UIView, toTrailing: UIView, inView: UIView, withMargin: CGFloat) {
        inView.addConstraint(NSLayoutConstraint(item: leading, attribute: .leading, relatedBy: .equal, toItem: toTrailing, attribute: .trailing, multiplier: 1, constant: withMargin))
    }
    
    @discardableResult public static func matchCenterY(of: UIView, and: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: of, attribute: .centerY, relatedBy: .equal, toItem: and, attribute: .centerY, multiplier: 1, constant: 0)
        of.superview!.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult public static func matchCenterX(of: UIView, and: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: of, attribute: .centerX, relatedBy: .equal, toItem: and, attribute: .centerX, multiplier: 1, constant: 0)
        of.superview!.addConstraint(constraint)
        return constraint
    }
    
    public static func setMaximumHeight(of subview: UIView, to multiplier: CGFloat) {
        let limit = NSLayoutConstraint(item: subview, attribute: .height, relatedBy: .lessThanOrEqual, toItem: subview.superview!, attribute: .height, multiplier: multiplier, constant: 0.0)
        limit.priority = .required
        
        NSLayoutConstraint.activate([
            limit
            ])
    }
    
    @discardableResult public static func setMaximumWidth(of subview: UIView, to multiplier: CGFloat) -> NSLayoutConstraint {
        let limit = NSLayoutConstraint(item: subview, attribute: .width, relatedBy: .lessThanOrEqual, toItem: subview.superview!, attribute: .width, multiplier: multiplier, constant: 0.0)
        limit.priority = .required
        
        NSLayoutConstraint.activate([
            limit
            ])
        
        return limit
    }
    
    @discardableResult public static func setMaximumWidth(of subview: UIView, toConstant constant: CGFloat) -> NSLayoutConstraint {
        let limit = NSLayoutConstraint(item: subview, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        limit.priority = .required
        
        NSLayoutConstraint.activate([
            limit
            ])
        return limit
    }
}

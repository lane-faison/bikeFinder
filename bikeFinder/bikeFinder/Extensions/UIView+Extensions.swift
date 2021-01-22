//
//  UIView+Extensions.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

extension UIView {
    
    /**
     Activates an array of NSLayoutConstraint objects that relates this view's top, leading, bottom and trailing to its superview, given an optional set of insets for each side.
     Default parameter values relate this view's top, leading, bottom and trailing to its superview with no insets.
     
     - parameters:
     - edgeInsets: An amount of insets to apply to the top, leading, bottom and trailing constraint. Default value is UIEdgeInsets.zero
     - useBottomSafeAreaLayout: If set to true, continues to use `superview.safeAreaLayoutGuide.bottomAnchor`
        for bottom anchor. if set to false, will use `superview.bottomAnchor`. Default value is true
     */
    @discardableResult public func activateEdgeConstraints(withEdgeInsets insets: UIEdgeInsets = .zero, useBottomSafeAreaLayout : Bool = true) -> [NSLayoutConstraint] {
        var edgeConstraints = [NSLayoutConstraint]()
        if let superview = superview {
            translatesAutoresizingMaskIntoConstraints = false
            edgeConstraints = [
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: useBottomSafeAreaLayout ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor, constant: -insets.bottom)
            ]
            NSLayoutConstraint.activate(edgeConstraints)
        }
        return edgeConstraints
    }
}

//
//  UIView+Extensions.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

extension UIView {
    
    static var bottomInsetHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }
    
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
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor,
                                     constant: insets.top),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor,
                                         constant: insets.left),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                                          constant: -insets.right),
                bottomAnchor.constraint(equalTo: useBottomSafeAreaLayout ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor,
                                        constant: -insets.bottom)
            ]
            NSLayoutConstraint.activate(edgeConstraints)
        }
        return edgeConstraints
    }
    
    /// Activates an array of NSLayoutConstraints based upon the provided anchor parameters
    ///
    /// - Parameters:
    ///   - top: NSLayoutYAxisAnchor for top constraint
    ///   - left: NSLayoutXAxisAnchor for left constraint
    ///   - bottom: NSLayoutYAxisAnchor for bottom constraint
    ///   - right: NSLayoutXAxisAnchor for right constraint
    ///   - insets: Layout margins to set as constants for each corresponding anchor
    ///   - height: desired height
    ///   - width: desired width
    /// - Returns: Activated NSLayoutConstraints
    @discardableResult public func anchor(top: NSLayoutYAxisAnchor? = nil,
                                          left: NSLayoutXAxisAnchor? = nil,
                                          bottom: NSLayoutYAxisAnchor? = nil,
                                          right: NSLayoutXAxisAnchor? = nil,
                                          insets: UIEdgeInsets = .zero,
                                          height: CGFloat? = nil,
                                          width: CGFloat? = nil) -> [NSLayoutConstraint] {
        var edgeConstraints = [NSLayoutConstraint]()
        
        if let top = top {
            edgeConstraints.append(topAnchor.constraint(equalTo: top,
                                                        constant: insets.top))
        }
        if let bottom = bottom {
            edgeConstraints.append(bottomAnchor.constraint(equalTo: bottom,
                                                           constant: -insets.bottom))
        }
        if let left = left {
            edgeConstraints.append(leadingAnchor.constraint(equalTo: left,
                                                            constant: insets.left))
        }
        if let right = right {
            edgeConstraints.append(trailingAnchor.constraint(equalTo: right,
                                                             constant: -insets.right))
        }
        if let height = height {
            edgeConstraints.append(heightAnchor.constraint(equalToConstant: height))
        }
        if let width = width {
            edgeConstraints.append(widthAnchor.constraint(equalToConstant: width))
        }
        if edgeConstraints.count > 0 {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(edgeConstraints)
        }

        return edgeConstraints
    }
    
    /// Creates a stack view using the provided views
    /// - Parameters:
    ///   - axis: vertical or horizontal stack view
    ///   - views: views to be included in the stack view
    ///   - spacing: space between views in the stack view
    ///   - alignment: layout of arranged views perpendicular to the stack view’s axis
    ///   - distribution: layout of arranged views parallel to the stack view’s axis
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
    
    /// Creates a vertical stack view using the provided views
    @discardableResult open func verticalStack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    /// Creates a horizontal stack view using the provided views
    @discardableResult open func horizontalStack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    /// Returns a view with the provided height
    @discardableResult open func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    /// Returns a view with the provided width
    @discardableResult open func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    /// Returns a square view with the provided dimension
    @discardableResult open func withDimension(_ dimension: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: dimension).isActive = true
        heightAnchor.constraint(equalToConstant: dimension).isActive = true
        return self
    }
}

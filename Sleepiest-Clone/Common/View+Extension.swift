//
//  View+Extension.swift
//  Sleepiest-Clone
//
//  Created by Kudzaishe Mhou on 24/11/2021.
//

import Foundation
import UIKit
import AsyncDisplayKit

extension UIView {
    func embed(_ view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }
}

extension ASDisplayNode {
    
    
    func fade(_ views: [ASDisplayNode]) {
        views.forEach { $0.alpha = 0 }
    }
    
    func showFaded(_ views: [ASDisplayNode]) {
        views.forEach { $0.alpha = 1 }
    }
    
    func insets(_ insets: UIEdgeInsets) -> ASInsetLayoutSpec {
        return ASInsetLayoutSpec(insets: insets, child: self)
    }
    
    func overlayed(by spec: ASLayoutSpec) -> ASOverlayLayoutSpec {
        return ASOverlayLayoutSpec(child: self, overlay: spec)
    }
    
    func overlayed(by node: ASDisplayNode) -> ASOverlayLayoutSpec {
        return ASOverlayLayoutSpec(child: self, overlay: node)
    }
    
    func overlayed(on spec: ASLayoutSpec) -> ASOverlayLayoutSpec {
        return ASOverlayLayoutSpec(child: spec, overlay: self)
    }
    
    func overlayed(on node: ASDisplayNode) -> ASOverlayLayoutSpec {
        return ASOverlayLayoutSpec(child: node, overlay: self)
    }
    
    func relative(horizontalPosition: ASRelativeLayoutSpecPosition, verticalPosition: ASRelativeLayoutSpecPosition, sizingOption: ASRelativeLayoutSpecSizingOption) -> ASRelativeLayoutSpec {
        return ASRelativeLayoutSpec(horizontalPosition: horizontalPosition, verticalPosition: verticalPosition, sizingOption: sizingOption, child: self)
    }
    
    func background(with node: ASDisplayNode) -> ASBackgroundLayoutSpec {
        return ASBackgroundLayoutSpec(child: self, background: node)
    }
}

extension UIEdgeInsets {
    
    static func all(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func top(_ inset: CGFloat) -> UIEdgeInsets {
        var mutable = self
        mutable.top = inset
        return mutable
    }
    
    mutating func bottom(_ inset: CGFloat) -> UIEdgeInsets {
        var mutable = self
        mutable.bottom = inset
        return mutable
    }
    
    mutating func left(_ inset: CGFloat) -> UIEdgeInsets {
        var mutable = self
        mutable.left = inset
        return mutable
    }
    
    mutating func right(_ inset: CGFloat) -> UIEdgeInsets {
        var mutable = self
        mutable.right = inset
        return mutable
    }
    
    static func top(_ inset: CGFloat) -> UIEdgeInsets {
        var insets: UIEdgeInsets = .zero
        insets.top = inset
        return insets
    }
    
    static func bottom(_ inset: CGFloat) -> UIEdgeInsets {
        var insets: UIEdgeInsets = .zero
        insets.bottom = inset
        return insets
    }
    
    static func left(_ inset: CGFloat) -> UIEdgeInsets {
        var insets: UIEdgeInsets = .zero
        insets.left = inset
        return insets
    }
    
    static func right(_ inset: CGFloat) -> UIEdgeInsets {
        var insets: UIEdgeInsets = .zero
        insets.right = inset
        return insets
    }
}

//
//  ActivityIndicatorNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/27.
//

import AsyncDisplayKit

class ActivityIndicatorNode: ASDisplayNode {
    
    private var activityIndicatorView: UIActivityIndicatorView {
        return self.view as! UIActivityIndicatorView
    }
    
    init(style: UIActivityIndicatorView.Style) {
        super.init()
        self.setViewBlock({ () ->
            UIView in
            return UIActivityIndicatorView(style: style)
        })
    }
    
    var isAnimating: Bool {
        set {
            if newValue {
                self.activityIndicatorView.startAnimating()
            }else{
                self.activityIndicatorView.stopAnimating()
            }
        }
        get {
            self.activityIndicatorView.isAnimating
        }
    }
    
    var color: UIColor {
        set {
            self.activityIndicatorView.color = newValue
        }
        get {
            self.activityIndicatorView.color
        }
    }
}


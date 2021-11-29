//
//  CustomColor.swift
//  Sleepiest-Clone
//
//  Created by Kudzaishe Mhou on 24/11/2021.
//

import Foundation
import UIKit


public enum Colors {
    public static let skyBlue = UIColor("3DAFF6")
    public static let palePurple = UIColor("C3A6FF")
    public static let paleGray = UIColor("979797")
    public static let darkBlue = UIColor("3DAFF6")
}

extension UIColor {
    convenience init(_ hexString: String) {
        let set: CharacterSet = .alphanumerics
        let hex = hexString.trimmingCharacters(in: set.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

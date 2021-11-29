//
//  CustomFont.swift
//  Sleepiest-Clone
//
//  Created by Kudzaishe Mhou on 23/11/2021.
//

import Foundation
import UIKit

public enum CustomFont {
    public static let montserratSemiBold = "Montserrat-SemiBold"
    public static let montserratRegular = "Montserrat-Regular"
    public static let montserratLight = "Montserrat-Light"
    public static let montserratItalics = "Montserrat-Italic"
    public static let montserratBold = "Montserrat-Bold"
}

extension UIFont {
  func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([.traits: [
      UIFontDescriptor.TraitKey.weight: weight]
    ])
    return UIFont(descriptor: newDescriptor, size: pointSize)
  }
}


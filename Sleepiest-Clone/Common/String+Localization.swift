//
//  String+Localization.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/28.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}

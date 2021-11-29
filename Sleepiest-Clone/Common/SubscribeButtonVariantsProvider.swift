//
//  SubscribeButtonVariantsProvider.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/28.
//

import Foundation

public typealias SubscribeButtonVariantsCallback = (String) -> Void

public protocol SubscribeButtonVariantsProvider {
    func fetchSubscribeButtonVariants(_ completion: @escaping SubscribeButtonVariantsCallback)
}

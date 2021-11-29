//
//  RemoteConfigFetchStatus+Extension.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/29.
//

import Foundation
import Firebase
import Combine

extension RemoteConfigFetchStatus {
    var debugDescription: String {
        switch self {
        case .failure:
            return "failure"
        case .noFetchYet:
            return "pending"
        case .success:
            return "success"
        case .throttled:
            return "throttled"
        @unknown default:
            return "unknown"
        }
    }
}

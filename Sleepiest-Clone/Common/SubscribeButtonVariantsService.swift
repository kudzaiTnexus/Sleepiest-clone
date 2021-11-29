//
//  SubscribeButtonVariantsService.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/28.
//

import Foundation

public final class SubscribeButtonVariantsService {
    
    private init() { }
    
    static let shared = SubscribeButtonVariantsService()
    private var buttonVariant = ""
//    private var featureToggles: [FeatureToggle] = []
    
    public func fetchFeatureToggles(mainProvider: SubscribeButtonVariantsProvider,
                                    fallbackProvider: SubscribeButtonVariantsProvider?,
                                    completion: @escaping (String) -> Void) {
        
        mainProvider.fetchSubscribeButtonVariants { [weak self] buttonVariant in
            guard let self = self else { return }
            
            if !buttonVariant.isEmpty {
                self.buttonVariant = buttonVariant
            } else if let fallbackProvider = fallbackProvider {
                
            }
            completion(buttonVariant)
        }

    }
    
//    public func isEnabled(_ feature: Feature) -> Bool {
//        let feature = featureToggles.first(where: { $0.feature == feature })
//        return feature?.enabled ?? false
//    }
    
    private func useFallbackButtonVariant(_ fallbackProvider: SubscribeButtonVariantsProvider) {
//        fallbackProvider.fetchFeatureToggles { [weak self] featureToggles in
//            if let self = self {
//                self.featureToggles = featureToggles
//            }
//        }
    }
}

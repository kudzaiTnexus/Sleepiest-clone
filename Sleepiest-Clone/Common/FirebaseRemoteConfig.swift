//
//  FirebaseRemoteConfig.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/28.
//

import Foundation
import Firebase

class FirebaseRemoteConfig {
    
    // MARK: Singleton
    
    static var shared = FirebaseRemoteConfig()
    private init(){}
    
    // MARK: Config Keys
    
    enum Keys {
      static let featureToggles = "subscribe_button_color"
    }
    
    // MARK: Properties
    
    var remoteConfig: RemoteConfig?
    var remoteConfigSettings: RemoteConfigSettings?
    
    // MARK: Main Functions
    
      func setup() {
          
          if(FirebaseApp.app() == nil) {
              FirebaseApp.configure()
              remoteConfig = RemoteConfig.remoteConfig()
              let settings = RemoteConfigSettings()

              #if DEBUG
                   settings.minimumFetchInterval = 0 // for dev testing
              #else
                   settings.minimumFetchInterval = 28800 //is the ideal time i.e 8 hours
              #endif

              remoteConfig?.configSettings = settings
          }
      }

}

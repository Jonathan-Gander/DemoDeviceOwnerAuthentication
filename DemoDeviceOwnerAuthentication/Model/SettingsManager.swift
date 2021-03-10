//
//  SettingsManager.swift
//  DemoDeviceOwnerAuthentication
//
//  Created by Jonathan Gander on 10.03.21.
//

import Foundation

class SettingsManager: ObservableObject {
    
    private let userDefaults = UserDefaults.standard
    
    // True when app is locked
    var securedApp: Bool {
        didSet {
            userDefaults.set(securedApp, forKey: keySecuredApp)
            userDefaults.synchronize()
        }
    }
    private let keySecuredApp = "key.securedapp"
    
    // MARK: - Initializer
    init() {
        
        // Load values from user defaults
        securedApp = userDefaults.bool(forKey: keySecuredApp)
    }
}

//
//  DemoDeviceOwnerAuthenticationApp.swift
//  DemoDeviceOwnerAuthentication
//
//  Created by Jonathan Gander on 10.03.21.
//

import SwiftUI

import LocalAuthentication

@main
struct DemoDeviceOwnerAuthenticationApp: App {
    
    @StateObject private var settingsManager = SettingsManager()
    
    @State private var isUnlocked = false
    @State private var noAuthentication = false
    @State private var canRetry = false
    
    var body: some Scene {
        WindowGroup {
            
            // If app is secured and still locked, display message
            if settingsManager.securedApp && !isUnlocked {
                VStack {
                    Text("lock.title")
                        .font(.title)
                        .padding(.top, 40)
                    
                    HStack {
                        
                        Image(systemName: "lock")
                        
                        Text("lock.islocked")
                            .font(.callout)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    
                    // Add message if device has no authentication
                    if noAuthentication {
                        Divider()
                        
                        HStack {
                            Image(systemName: "exclamationmark.square")
                                .foregroundColor(.red)
                            
                            Text("lock.authentication")
                        }
                        .padding()
                        
                        Divider()
                        
                    }
                    
                    if canRetry {
                        Button("lock.retry") {
                            self.canRetry = false
                            authenticate()
                        }
                        .padding()
                    }
                    Spacer()
                }
                .onAppear(perform: authenticate)
            }
            // If app is not secured or it's unlocked, can load main view (list of lists of memories)
            else {
                ContentView()
                    .environmentObject(settingsManager)
            }
        }
    }
    
    // Check and start authentication   
    func authenticate() {
        let laContext = LAContext()
        var error: NSError?

        // Check if device has available authentication (code, Face ID, Touch ID)
        if laContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            self.noAuthentication = false
            
            // Start authentication
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: NSLocalizedString("lock.reason", comment: "")) { success, authenticationError in
                // Authentication finished
                DispatchQueue.main.async {
                    if success {
                        // Authentication successfull
                        self.isUnlocked = true
                    } else {
                        // Authentication failed
                        self.canRetry = true
                    }
                }
            }
        } else {
            // No authentication available
            self.noAuthentication = true
            self.canRetry = true
        }
    }
}

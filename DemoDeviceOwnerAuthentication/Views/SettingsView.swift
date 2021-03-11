//
//  SettingsView.swift
//  DemoDeviceOwnerAuthentication
//
//  Created by Jonathan Gander on 10.03.21.
//

import SwiftUI

import LocalAuthentication

struct SettingsView: View {
    
    @EnvironmentObject var settingsManager: SettingsManager
    
    // To open/close view
    @Binding var showView: Bool
    
    // Fields
    @State private var fieldSecuredApp: Bool = false
    
    // UI controls
    @State private var appHasAuthentication: Bool = false
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(footer: Text(appHasAuthentication ? "sv.securedapp.footer.auth" : "sv.securedapp.footer.noauth")) {
                    
                    Toggle("sv.securedapp", isOn: $fieldSecuredApp)
                        .disabled(!appHasAuthentication)
                        .onAppear {
                            // Set current value to previously saved one
                            fieldSecuredApp = settingsManager.securedApp
                        }
                        .foregroundColor(appHasAuthentication ? .primary : .secondary)
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear() {
                // Check if an authentication is available or not
                checkAuthentication()
            }
            
            // Navigation bar parameters
            .navigationBarTitle(Text("sv.title"), displayMode: .inline)
            .navigationBarItems(
                // Done button
                trailing: Button(action: {
                    
                    // Save all settings
                    settingsManager.securedApp = fieldSecuredApp
                    
                    // And close view
                    self.showView = false

                }) {
                    Text("done")
                }
            )
        }
    }
    
    // Check if authentication is available
    func checkAuthentication() {
        let laContext = LAContext()
        var error: NSError?
        
        // Check if device has available authentication (passcode, Face ID, Touch ID)
        self.appHasAuthentication = laContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    @State static private var showView = true
    
    static var previews: some View {
        SettingsView(showView: $showView)
    }
}

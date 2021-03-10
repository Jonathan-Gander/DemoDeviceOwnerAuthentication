//
//  ContentView.swift
//  DemoDeviceOwnerAuthentication
//
//  Created by Jonathan Gander on 10.03.21.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("mv.placeholder")
                    .padding()
                
                Divider()
                
                HStack {
                    
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.blue)
                    
                    Text("mv.instructions")
                        
                }
                .padding()
                
                Divider()
                
                Spacer()
            }
            
            // Navigation bar settings
            .navigationTitle("mv.title")
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    // Settings button
                    Button(action: { self.showSettings = true }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                    // Modal view for SettingsView
                    .sheet(isPresented: $showSettings) {
                        SettingsView(showView: $showSettings)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

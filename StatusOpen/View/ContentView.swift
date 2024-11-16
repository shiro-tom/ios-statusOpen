//
//  ContentView.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/14.
//
import SwiftUI
import Foundation

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Statusビュー
            NavigationView {
                StatusView()
            }
            .tabItem {
                Label("Status", systemImage: "person.fill")
            }
            
            // Settingsビュー
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}




#Preview {
    ContentView()
}

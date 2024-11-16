//
//  StatusOpenApp.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/14.
//

import SwiftUI

@main
struct StatusOpenApp: App {
    @StateObject var statusManager = StatusManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(statusManager)
        }
    }
}

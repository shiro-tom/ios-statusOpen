//
//  Profile.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//

import SwiftUI
import Foundation

struct Profile: Identifiable, Codable {
    
    var id: UUID = UUID()
    var name: String
    var level: Double
}

//
//  TrainingView.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//

import SwiftUI
import Foundation

struct TrainingView: View {
    @EnvironmentObject var statusManager: StatusManager
    @State private var newItemName: String = ""
    var training: TrainingList  // 受け取るプロパティ
    
    var body: some View {
        VStack {
            Text(training.name)
                .font(.title)
            Text("Level: \(training.level, specifier: "%.1f")")
                .font(.subheadline)
            ProgressView(value: training.level)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(width: 100)
            
            
            
            List {
                ForEach(training.trainingItems) { item in
                    Text(item.detailName)
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        // アイテムを削除
                        if let trainingIndex = statusManager.trainingList.firstIndex(where: { $0.id == training.id }) {
                            statusManager.trainingList[trainingIndex].removeTrainingItem(at: index)
                        }
                    }
                }
            }
            
            TextField("新しいアイテムを追加", text: $newItemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("アイテムを追加") {
                if !newItemName.isEmpty {
                    if let trainingIndex = statusManager.trainingList.firstIndex(where: { $0.id == training.id }) {
                        statusManager.trainingList[trainingIndex].addTrainingItem(detailName: newItemName)
                        newItemName = ""
                    }
                }
            }
            .padding()
            
            
        }
        .padding()
    }
}

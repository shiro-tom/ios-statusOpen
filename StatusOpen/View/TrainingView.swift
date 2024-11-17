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
    @State private var showDeleteAlert = false
    @State private var deleteIndexSet: IndexSet?
    @Binding var training: TrainingList
    
    var body: some View {
        VStack(alignment: .leading) {
            // トレーニング情報の表示
            Text(training.name)
                .font(.title)
            HStack{
                Text("Lv, : \(training.level * 100, specifier: "%.1f")")
                    .font(.subheadline)
                
                
                CustomProgressBarSmall(progress: training.level)
                    .frame(width: 150, height: 25)
                //    .padding(.top, 10)
            }
            
            
            // アイテムリスト
            List {
                ForEach($training.trainingItems) { $item in
                    HStack {
                        // チェックボックス
                        Button(action: {
                            item.isChecked.toggle()
                        }) {
                            Image(systemName: item.isChecked ? "checkmark.square" : "square")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Text(item.detailName)
                    }
                }
                .onDelete { indexSet in
                    showDeleteAlert = true
                    deleteIndexSet = indexSet
                }
            }
            
            // 削除確認アラート
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("本当に削除しますか？"),
                    message: Text("このアイテムを削除すると元に戻せません。"),
                    primaryButton: .destructive(Text("削除")) {
                        if let indexSet = deleteIndexSet,
                           let trainingIndex = statusManager.trainingList.firstIndex(where: { $0.id == training.id }) {
                            for index in indexSet {
                                statusManager.trainingList[trainingIndex].removeTrainingItem(at: index)
                            }
                            deleteIndexSet = nil
                        }
                    },
                    secondaryButton: .cancel(Text("キャンセル"))
                )
            }
            
            // 合計アイテム数とチェック済みアイテム数の表示
            Text("合計アイテム数: \(training.totalItemCount)")
            Text("チェック済みアイテム数: \(training.checkedItemCount)")
            
            // 新しいアイテムを追加
            TextField("新しいアイテムを追加", text: $newItemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
            
            Button("アイテムを追加") {
                if !newItemName.isEmpty {
                    if let trainingIndex = statusManager.trainingList.firstIndex(where: { $0.id == training.id }) {
                        statusManager.trainingList[trainingIndex].addTrainingItem(detailName: newItemName)
                        newItemName = ""
                    }
                }
            }
            .padding(.top, 5)
        }
        .padding()
    }
}









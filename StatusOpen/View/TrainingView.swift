//
//  TrainingView.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//
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
        VStack(alignment: .leading, spacing: 20) {
            // トレーニング情報
            VStack(alignment: .leading, spacing: 15) {
                Text(training.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("Lv: \(training.level * 100, specifier: "%.1f")")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    CustomProgressBarSmall(progress: training.level)
                        .frame(width: 150, height: 8)
                        .padding(.leading, 10)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

            // アイテムリスト
            List {
                ForEach($training.trainingItems) { $item in
                    HStack {
                        Button(action: {
                            item.isChecked.toggle()
                            training.sortItems() // 並び替えを呼び出し
                        }) {
                            Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                                .foregroundColor(item.isChecked ? .blue : .gray)
                                .font(.title2)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Text(item.detailName)
                            .font(.body)
                            .foregroundColor(item.isChecked ? .gray : .primary)
                            .strikethrough(item.isChecked, color: .gray)
                    }
                    .padding(.vertical, 5)
                }
                .onDelete { indexSet in
                    showDeleteAlert = true
                    deleteIndexSet = indexSet
                }
            }
 //           .frame(maxWidth: .infinity)
            
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
            .listStyle(InsetGroupedListStyle())
            .background(Color(.systemGroupedBackground))
            
            // 合計アイテム数とチェック済みアイテム数
            VStack(alignment: .leading, spacing: 8) {
                Text("合計アイテム数: \(training.totalItemCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("チェック済みアイテム数: \(training.checkedItemCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            // 新しいアイテムを追加
            VStack(spacing: 10) {
                TextField("新しいアイテムを追加", text: $newItemName)
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    if !newItemName.isEmpty {
                        if let trainingIndex = statusManager.trainingList.firstIndex(where: { $0.id == training.id }) {
                            statusManager.trainingList[trainingIndex].addTrainingItem(detailName: newItemName)
                            newItemName = ""
                            training.sortItems() // 並び替えを呼び出し
                        }
                    }
                }) {
                    Text("アイテムを追加")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                }
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground).opacity(0.8))
        .cornerRadius(16)
        .padding()
    }
}


extension TrainingList {
    // 並び替えメソッドを追加
    var sortedTrainingItems: [TrainingItemList] {
        trainingItems.sorted { lhs, rhs in
            if lhs.isChecked == rhs.isChecked {
                return lhs.id > rhs.id // 新しいアイテムが上に来る
            }
            return !lhs.isChecked && rhs.isChecked // チェックされたアイテムが下に来る
        }
    }
    
    mutating func sortItems() {
        trainingItems = sortedTrainingItems
    }
}








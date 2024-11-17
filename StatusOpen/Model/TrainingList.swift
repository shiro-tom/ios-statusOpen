//
//  TrainingList.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//

import SwiftUI
import Foundation

struct TrainingList: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String  // トレーニング名
  //  var level: Double  // トレーニングのレベル
    var trainingItems: [TrainingItemList]  // TrainingItemListのリスト
    
    
    
    // チェック割合を基にしたレベル (0.0〜1.0)
    var level: Double {
        guard totalItemCount > 0 else { return 0.0 } // 0のとき0.0を返す
        return Double(checkedItemCount) / Double(totalItemCount)
    }
    
    
    // 合計アイテム数
    var totalItemCount: Int {
        trainingItems.count
    }
    
    // チェックされたアイテム数
    var checkedItemCount: Int {
        trainingItems.filter { $0.isChecked }.count
    }
    
    
    
    // トレーニングアイテムを追加するメソッド
    mutating func addTrainingItem(detailName: String) {
        let newItem = TrainingItemList(detailName: detailName)
        trainingItems.append(newItem)
    }
    
    // トレーニングアイテムを削除するメソッド
    mutating func removeTrainingItem(at index: Int) {
        if index >= 0 && index < trainingItems.count {
            trainingItems.remove(at: index)
        }
    }
}



struct TrainingItemList: Identifiable, Codable {
    var id: UUID = UUID()
    var detailName: String  // 例えばトレーニング項目の詳細名
//    var level: Double = 0.0  // 必要に応じてレベルを追加
    var isChecked: Bool = false
}

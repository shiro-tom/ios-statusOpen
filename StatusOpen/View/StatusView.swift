//
//  StatusView.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//






import SwiftUI
import Foundation

struct StatusView: View {
    @EnvironmentObject var statusManager: StatusManager
     
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                // ヘッダービュー: 画像、レベル、バー、名前
                HeaderView(mainLevel: statusManager.userProfile.level)
                    .padding(.horizontal, 50)
                    .padding(.top, 50)
                
                // トレーニング項目のリスト
                List {
                    ForEach(statusManager.trainingList) { training in
                        NavigationLink(destination: TrainingView(training: training)) {
                            TrainingRowView(training: training)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

// ヘッダービュー
struct HeaderView: View {
    let mainLevel: Double
    @EnvironmentObject var statusManager: StatusManager
    
    var body: some View {
        HStack {
            // 丸いプロフィール画像
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            // レベルとバー
            VStack(alignment: .leading) {
                HStack {
                    Text("Lv,")
                        .font(.caption)
                    Text("\(mainLevel * 10, specifier: "%.0f")")  // レベル表示
                        .font(.caption)
                }
                
                // レベルを視覚的に表すバー
                ProgressView(value: mainLevel)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 100)
                
                // 名前
                Text("\(statusManager.userProfile.name)")
                    .font(.title2)
            }
            .padding(.horizontal, 20)
        }
    }
}

// トレーニング行のビュー
struct TrainingRowView: View {
    let training: TrainingList

    var body: some View {
        VStack(alignment: .leading) {
            Text(training.name)
            Spacer()
            HStack {
                Text("Lv: \(training.level, specifier: "%.1f")")
                    .font(.caption)
                
                // レベルバー
                ProgressView(value: training.level * 0.1)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 100)
            }
        }
    }
}











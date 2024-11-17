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
            VStack(spacing: 20) {
                
                // ヘッダービュー（カード風にカスタマイズ）
                HeaderView(mainLevel: statusManager.userProfile.level)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                
                // トレーニング項目のリスト
                ScrollView {
                    VStack(spacing: 15) {  // 各要素の間にスペースを追加
                        if statusManager.trainingList.isEmpty {
                            Text("まだアイテムがありません")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity)
                        } else {
                            ForEach($statusManager.trainingList) { $training in
                                NavigationLink(destination: TrainingView(training: $training)) {
                                    TrainingRowView(training: training)
                                        .padding()
                                        .background(Color.white)  // カード風の背景色
                                        .cornerRadius(12)         // 角を丸く
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)  // 軽いシャドウで区切り
                                        .frame(maxWidth: .infinity, alignment: .leading)  // 横幅を最大に設定
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                .background(Color(UIColor.white).opacity(0.8)) // リスト全体に背景色
                .cornerRadius(12)
                .padding(.horizontal, 16)  // 左右の余白を統一

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)  // 背景を全画面に広げる
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)) // 全体背景
        }
    }
}

// ヘッダービュー
struct HeaderView: View {
    let mainLevel: Double
    @EnvironmentObject var statusManager: StatusManager
    
    var body: some View {
        VStack{
            HStack(spacing: 20) {
                // 丸いプロフィール画像
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .background(Circle().fill(Color.white.opacity(0.8)))
                    .clipShape(Circle())
                    .shadow(radius: 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 5) {
                        Text("\(statusManager.userProfile.name)")
                            .font(.caption)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text("Lv, ")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(statusManager.overallLevel * 100, specifier: "%.2f")")
                            .font(.caption)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    // ゲーム風の進行状況バー
                    CustomProgressBar(progress: statusManager.overallLevel)
                        .frame(width: 200, height: 20)
                        .padding(.top, 5)
                    
                }
                Spacer()
            }
            HStack{
                Text("目標 : ")
                Text("\(statusManager.userProfile.Goal)")
            }
            .padding(10)
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.bold)
            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)) // 半透明の枠線
            
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
        .frame(maxWidth: .infinity, alignment: .center)  // 横幅を最大に設定
    }
}

// トレーニング行のビュー
struct TrainingRowView: View {
    let training: TrainingList
    @EnvironmentObject var statusManager: StatusManager

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(training.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            HStack {
                Text("Lv, \(training.level * 100, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                CustomProgressBarSmall(progress: training.level)
                    .frame(width: 150, height: 8)
                    .padding(.leading, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)  // 横幅を最大に設定
    }
}

// カスタム進行状況バー
struct CustomProgressBar: View {
    var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 10)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .frame(width: CGFloat(progress) * 200, height: 10)
                .animation(.easeInOut(duration: 0.5), value: progress)
        }
    }
}

// 小さいカスタム進行状況バー
struct CustomProgressBarSmall: View {
    var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 8)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .frame(width: CGFloat(progress) * 150, height: 8)
                .animation(.easeInOut(duration: 0.5), value: progress)
        }
    }
}













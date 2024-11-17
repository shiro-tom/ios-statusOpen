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
                    ForEach($statusManager.trainingList) { $training in
                        NavigationLink(destination: TrainingView(training: $training)) {
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
                    Text("\(statusManager.overallLevel * 100, specifier: "%.2f")")  // レベル表示
                        .font(.caption)
                }
                
      
//                ProgressView(value: statusManager.overallLevel)
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .frame(width: 100)
                
                
                // ゲーム風の進行状況バー
                CustomProgressBar(progress: statusManager.overallLevel)
                    .frame(width: 250, height: 25)
                    .padding(.top, 10)
                
                
                
                // 名前
                Text("\(statusManager.userProfile.name)")
                    .font(.title2)
            }
            .padding(.horizontal, 20)
        }
    }
}



// 洗練された進行状況バー
//struct ProgressBarView: View {
//    var progress: Double
//    
//    var body: some View {
//        ZStack {
//            // バーの背景（グレー）
//            RoundedRectangle(cornerRadius: 12)
//                .fill(Color.gray.opacity(0.2))
//                .frame(height: 25)
//            
//            // 進行状況バー（グラデーション）
//            RoundedRectangle(cornerRadius: 12)
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
//                .frame(width: CGFloat(progress) * 250, height: 25)
//                .animation(.easeInOut(duration: 0.5), value: progress)
//            
//            // 進行状況のテキスト（％表示）
//            Text("\(Int(progress * 100))%")
//                .foregroundColor(.white)
//                .bold()
//                .font(.system(size: 14))
//                .padding(.leading, 10)
//                .opacity(progress > 0 ? 1 : 0)  // 進行状況が0の場合は非表示
//        }
//    }
//}




// トレーニング行のビュー
struct TrainingRowView: View {
    let training: TrainingList
    @EnvironmentObject var statusManager: StatusManager

    var body: some View {
        VStack(alignment: .leading) {
            Text(training.name)
            Spacer()
            HStack {
                Text("Lv, \(training.level * 100, specifier: "%.1f")")
                    .font(.caption)
                
                // レベルバー
//                ProgressView(value: training.level)
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .frame(width: 100)
                
                
                CustomProgressBarSmall(progress: training.level)
                    .frame(width: 150, height: 25)
      //              .padding(.top, 10)
                
                
                
            }
        }
    }

}






// 進行状況バー（完全カスタムな実装）
struct CustomProgressBar: View {
    var progress: Double
    
    var body: some View {
        HStack {
            ZStack {
                // 背景色
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                
                // 進行状況バー
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: CGFloat(progress) * geometry.size.width, height: 20)
                        .animation(.easeInOut(duration: 0.5), value: progress)
                }
            }
            .frame(height: 20) // 高さの指定


        }
    }
}


struct CustomProgressBarSmall: View {
    var progress: Double
    
    var body: some View {
        HStack {
            ZStack {
                // 背景色
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 10) // 小さい高さ
                
                // 進行状況バー
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: CGFloat(progress) * geometry.size.width, height: 10) // 小さい高さ
                        .animation(.easeInOut(duration: 0.5), value: progress)
                }
            }
            .frame(height: 10) // 高さの指定
        }
    }
}

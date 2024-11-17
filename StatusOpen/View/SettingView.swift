//
//  SettingView.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//




import SwiftUI
import Foundation

struct SettingsView: View {
    @EnvironmentObject var statusManager: StatusManager
    @State private var newName: String = ""
    @State private var userNewName: String = ""
    @State private var userNewGoal: String = ""
    @State private var showAlert: Bool = false
    @State private var selectedItems: IndexSet? = nil

    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    Divider()
                    
                    userNameInputView()
                    
                    Divider()
                    
                    userGoalInputView()
                    
                    Divider()
                    
                    
                    trainingInputView()
                    
                    
                    trainingListView()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("削除の確認"),
                        message: Text("本当にこのトレーニングを削除しますか？"),
                        primaryButton: .destructive(Text("削除")) {
                            if let selectedItems = selectedItems {
                                statusManager.deleteTraining(at: selectedItems)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .gesture(
                    TapGesture().onEnded {
//                        hideKeyboard()
                    }
                )
            }
        }
    }
    
    // ユーザー名の入力と変更ボタン
    private func userNameInputView() -> some View {
        HStack(spacing: 16) {
            TextField("新しいユーザー名を入力", text: $userNewName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .onTapGesture {
                    // テキストフィールドタップ時にキーボード表示
//                    hideKeyboard()
                }

            Button(action: {
                if !userNewName.isEmpty {
                    statusManager.changeUserName(name: userNewName)
                    userNewName = ""
                }
            }) {
                buttonLabel("変更")
            }
        }
        .padding(.vertical, 10)
    }

    
    
    private func userGoalInputView() -> some View {
        HStack(spacing: 16) {
            
            ZStack(alignment: .topLeading) {
 
                TextEditor(text: $userNewGoal)
                
                if userNewGoal.isEmpty {
                    Text("新しい目標を入力")
                        .foregroundColor(.gray.opacity(0.4))
                        .padding(.horizontal, 8)
                        .padding(.top, 8)
                }
                
                
            }
            .padding(5)  // 内側の余白
            .autocapitalization(.none)
            .frame(height: 60)  // 高さを設定（約2行分）
            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)) // 枠線を追加
            .padding(.horizontal)
            

            Button(action: {
                if !userNewGoal.isEmpty {
                    statusManager.changeUserGoal(goal: userNewGoal)
                    userNewGoal = ""
                }
            }) {
                buttonLabel("変更")
            }
        }
        .padding(.vertical, 10)
    }
    
    
    
    
    // トレーニング項目リスト
    private func trainingListView() -> some View {
        List {
            ForEach(statusManager.trainingList) { training in
                VStack(alignment: .leading) {
                    Text(training.name)
                        .font(.title2)
                        .padding(.vertical, 5)
                }
            }
            .onDelete(perform: { indexSet in
                self.selectedItems = indexSet
                self.showAlert = true
            })
        }
    }

    // 新しいトレーニングの入力と追加ボタン
    private func trainingInputView() -> some View {
        HStack(spacing: 16) {
            TextField("トレーニング名を入力", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
            
            Button(action: {
                if !newName.isEmpty {
                    statusManager.addTraining(name: newName)
                    newName = ""
                }
            }) {
                buttonLabel("追加")
            }
        }
        .padding(.vertical, 10)
    }

    // ボタン共通の見た目設定
    private func buttonLabel(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .padding(.vertical, 5)
            .frame(maxWidth: 100)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            .shadow(radius: 5)
            .scaleEffect(1.05)
            .animation(.spring(), value: true)
    }
    
    // キーボードを閉じる処理
//    private func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
}




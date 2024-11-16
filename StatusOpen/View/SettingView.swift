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
    
    @State private var showAlert: Bool = false
    @State private var selectedItems: IndexSet? = nil  // 削除対象のアイテムを保持
    
    
    
    var body: some View {
        VStack {
            currentUserNameView()
            userNameInputView()
            trainingInputView()
            trainingListView()
            Spacer()
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
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
    }
    
    
    
    // 現在のユーザー名表示
    private func currentUserNameView() -> some View {
        HStack {
            Text("現在の名前")
            Text(statusManager.userProfile.name)
        }
        .padding(.top, 50)
    }
    
    // 新しいユーザー名の入力と変更ボタン
    private func userNameInputView() -> some View {
        VStack {
            TextField("新しいユーザー名を入力", text: $userNewName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if !userNewName.isEmpty {
                    statusManager.changeUserName(name: userNewName)
                    userNewName = ""  // フィールドをクリア
                }
            }) {
                buttonLabel("変更")
            }
        }
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
                self.selectedItems = indexSet  // 削除するアイテムのインデックスを保持
                self.showAlert = true  // アラートを表示
            })
        }
    }
    
    // 新しいトレーニングの入力と追加ボタン
    private func trainingInputView() -> some View {
        VStack {
            TextField("トレーニング名を入力", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if !newName.isEmpty {
                    statusManager.addTraining(name: newName)
                    newName = ""  // フィールドをクリア
                }
            }) {
                buttonLabel("追加")
            }
        }
    }
    
    // ボタン共通の見た目設定
    private func buttonLabel(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    

    
    
}











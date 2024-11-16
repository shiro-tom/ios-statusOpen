//
//  StatusManager.swift
//  StatusOpen
//
//  Created by 白石友樹 on 2024/11/16.
//

import SwiftUI
import Foundation


class StatusManager: ObservableObject {
    @Published var userProfile: Profile {
        didSet {
            saveUserProfile()
        }
    }
    
    @Published var trainingList: [TrainingList] = [] {
        didSet {
            saveTrainingList()
        }
    }
    
    init() {
        
        self.userProfile = Profile(name: "unknown", level: 0)
        
        loadUserProfile()     // アプリ起動時にプロファイルを読み込む
        loadTrainingList()    // アプリ起動時にトレーニングリストを読み込む
    }
    
    // プロファイルのユーザー名を変更
    func changeUserName(name: String) {
        userProfile.name = name
    }
    
    // トレーニングリストに新しい項目を追加する
    func addTraining(name: String) {
        let newTraining = TrainingList(name: name, level: 0, trainingItems: [])
        trainingList.append(newTraining)
    }
    
    // UserDefaultsにプロファイルを保存
    private func saveUserProfile() {
        if let encodedData = try? JSONEncoder().encode(userProfile) {
            UserDefaults.standard.set(encodedData, forKey: "userProfile")
        }
    }
    
    // UserDefaultsからプロファイルを読み込む
    private func loadUserProfile() {
        if let savedData = UserDefaults.standard.data(forKey: "userProfile"),
           let decodedData = try? JSONDecoder().decode(Profile.self, from: savedData) {
            userProfile = decodedData
        } else {
            // 初回起動時など、データがない場合のデフォルト値
            userProfile = Profile(name: "unknown", level: 0)
        }
    }
    
    // UserDefaultsにトレーニングリストを保存
    private func saveTrainingList() {
        if let encodedData = try? JSONEncoder().encode(trainingList) {
            UserDefaults.standard.set(encodedData, forKey: "trainingList")
        }
    }
    
    // UserDefaultsからトレーニングリストを読み込む
    private func loadTrainingList() {
        if let savedData = UserDefaults.standard.data(forKey: "trainingList"),
           let decodedData = try? JSONDecoder().decode([TrainingList].self, from: savedData) {
            trainingList = decodedData
        }
    }
    
    func deleteTraining(at offsets: IndexSet) {
        // トレーニングリストからアイテムを削除
        trainingList.remove(atOffsets: offsets)
        
        // UserDefaultsからも削除
        saveTrainingList()
    }
    
}




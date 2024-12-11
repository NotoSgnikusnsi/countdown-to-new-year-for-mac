//
//  countdown_to_new_yearApp.swift
//  countdown-to-new-year
//
//  Created by Noto on 2024/12/11.
//

import SwiftUI

@main
struct countdown_to_new_yearApp: App {
    @StateObject private var timeManager = TimeManager()
    
    var body: some Scene {
        MenuBarExtra {
            MenuView()
        } label: {
            Text("\(timeManager.secondsUntilNewYear)")
        }
    }
}

class TimeManager: ObservableObject {
    @Published var secondsUntilNewYear: Int = 0
    private var timer: Timer?
    
    init() {
        updateTime()
        // タイマーを初期化し、1秒ごとに更新
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }
    
    private func updateTime() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // 次の年の1月1日0:00を設定
        var components = DateComponents()
        components.year = calendar.component(.year, from: currentDate) + 1
        components.month = 1
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        if let newYear = calendar.date(from: components) {
            secondsUntilNewYear = Int(newYear.timeIntervalSince(currentDate))
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

struct MenuView: View {
    var body: some View {
        VStack {
            Text("New Year Count Down")
                .font(.headline)
                .padding()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .padding()
        }
    }
}

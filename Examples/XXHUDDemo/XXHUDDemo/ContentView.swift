//
//  File.swift
//  XXHUDDemo
//
//  Created by nhn on 2025/9/17.
//

import SwiftUI
import XXHUD

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("加载") {
                if let window = UIApplication.shared.windows.first {
                    XXHUD.shared.enqueue(in: window, text: "加载中...", style: .loading, duration: 2)
                }
            }
            
            Button("成功") {
                if let window = UIApplication.shared.windows.first {
                    XXHUD.shared.enqueue(in: window, text: "成功", style: .success(), duration: 2)
                }
            }
            Button("提示") {
                if let window = UIApplication.shared.windows.first {
                    XXHUD.shared.enqueue(in: window, text: "点击按钮", style: .info, duration: 2)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

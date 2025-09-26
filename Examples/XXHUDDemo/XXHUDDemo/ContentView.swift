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
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
//                    XXHUD.shared.enqueue(in: window, text: "加载中...", style: .loading, duration: 2)
                    XXHUD.show(in: window, text: "加载中...", style: .loading, duration: 2)
                }
            }
            
            Button("成功1") {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
//                    XXHUD.shared.enqueue(in: window, text: "成功", style: .success(image: UIImage(systemName: "backward.fill")), duration: 2)
                    XXHUD.show(in: window, text: "成功", style: .success(image: UIImage(systemName: "backward.fill")), duration: 2)
                }
            }
            
            Button("成功2") {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
//                    XXHUD.shared.enqueue(in: window, text: "成功", style: .success(), duration: 2)
                    XXHUD.show(in: window, text: "成功", style: .success(), duration: 2)
                }
            }
            Button("提示") {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
//                    XXHUD.shared.enqueue(in: window, text: "这是一个提示", style: .info, duration: 2)
                    XXHUD.show(in: window, text: "这是一个提示", style: .info, duration: 2)
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

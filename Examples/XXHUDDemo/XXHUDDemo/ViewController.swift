//
//  ViewController.swift
//  XXHUDDemo
//
//  Created by nhn on 2025/9/17.
//

import UIKit
import XXHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // 显示加载
//        XXHUD.shared.enqueue(in: self.view, text: "加载中............", style: .loading)

        // 显示成功提示 2 秒
//        XXHUD.shared.enqueue(in: self.view, text: "成功", style: .custom(image: UIImage(systemName: "backward.fill")!), duration: 2)
        XXHUD.shared.enqueue(in: self.view, text: "成功", style: .success(), duration: 2)
        
//        XXHUD.shared.enqueue(in: self.view, text: "成功", style: .info, duration: 2)
////         隐藏 HUD
//        XXHUD.shared.hide()

    }


}


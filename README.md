XXHUD

XXHUD 是一个轻量级、可队列管理的 HUD 库，支持多类型提示（Loading / Success / Error / Info / Custom），具有渐入渐出 + 弹跳动画，并可全局配置 HUD 风格。

适用于 UIKit 和 SwiftUI 项目，支持 Swift Package Manager (SPM) 引入。


特性:

队列管理，连续调用 HUD 按顺序显示

全局默认配置：圆角、背景色、字体、动画时长、HUD 大小

多类型 HUD：Loading / Success / Error / Info / Custom 图标

渐入渐出 + 弹跳动画

UIKit / SwiftUI 通用

纯 Swift + SPM 可用

安装:

Swift Package Manager

打开 Xcode → File → Add Packages

要使用Swift包管理进行安装，请将以下内容添加到Package.Swift文件的“dependencies:”部分：

```swift
.package(url: "[https://github.com/nicklockwood/LRUCach](https://github.com/tianxiiao/XXHUD.git", .upToNextMinor(from: "1.0.0")),
```

Add Package

引入：

```swift
import XXHUD
```

调用
```swift
        // 显示加载
        XXHUD.shared.enqueue(in: self.view, text: "加载中............", style: .loading)

        // 带图标提示
        XXHUD.shared.enqueue(in: self.view, text: "自定义图标", style: .custom(image: UIImage(systemName: "backward.fill")!), duration: 2)
        XXHUD.shared.enqueue(in: window, text: "成功", style: .success(), duration: 2)
        XXHUD.shared.enqueue(in: window, text: "成功", style: .error(), duration: 2)
        
        // 仅显示信息
        XXHUD.shared.enqueue(in: window, text: "这是一个提示", style: .info, duration: 2)
        // 隐藏 HUD
        XXHUD.shared.hide()
```

import UIKit
import Foundation

@MainActor
public class XXHUD {
    public static let shared = XXHUD()
    
    private var hudView: UIView?
    private var hudQueue: [(view: UIView, text: String?, style: HUDStyle, duration: TimeInterval?)] = []
    private var isShowing = false
    
    public var configuration = HUDConfiguration()
    
    private init() {}
    
    // MARK: - 类型方法
    
    public static func hide() {
        shared.hideHUD()
    }
    
    // MARK: - 显示 HUD
    ///特殊场景使用，不建议使用
    public static func showQueue(in view: UIView? = nil, text: String? = nil, style: HUDStyle = .loading, duration: TimeInterval? = nil) {
        let targetView = view ?? topMostView()
        shared.enqueue(in: targetView, text: text, style: style, duration: duration)
    }
    
    func enqueue(in view: UIView, text: String?, style: HUDStyle, duration: TimeInterval?) {
        hudQueue.append((view, text, style, duration))
        displayNextIfNeeded()
    }
    
    private func displayNextIfNeeded() {
        guard !isShowing, !hudQueue.isEmpty else { return }
        isShowing = true
        let next = hudQueue.removeFirst()
        showHUD(in: next.view, text: next.text, style: next.style, duration: next.duration)
    }
    
    ///推荐使用
    public static func show(in view: UIView? = nil, text: String? = nil, style: HUDStyle = .info, duration: TimeInterval? = 2) {
        let targetView = view ?? topMostView()
        shared.showHUD(in: targetView, text: text, style: style, duration: duration)
    }
    
    func showHUD(in view: UIView, text: String?, style: HUDStyle, duration: TimeInterval?) {
        hudView?.removeFromSuperview()
        
        let container = UIView(frame: view.bounds)
        container.backgroundColor = (style == .info) ? UIColor.clear : configuration.containerBackgroundColor
        container.alpha = 0
        
        let box = UIView()
        box.backgroundColor = configuration.boxBackgroundColor
        box.layer.cornerRadius = configuration.cornerRadius
        box.layer.shadowColor = configuration.shadowColor.cgColor
        box.layer.shadowOpacity = configuration.shadowOpacity
        box.layer.shadowOffset = configuration.shadowOffset
        box.layer.shadowRadius = configuration.shadowRadius
        box.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(box)
        view.addSubview(container)
        
        // --- 动态内容容器 ---
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        box.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: box.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: box.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: box.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: box.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: box.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: box.bottomAnchor, constant: -12),
        ])
        
        // --- 图标视图 ---
        var iconView: UIView?
        switch style {
        case .loading:
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.startAnimating()
            iconView = indicator
        case .success(let image, let tintColor):
            let image = image ?? UIImage.xxhud(named: "success")
            var imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
            if let tint = tintColor {
                imageView.tintColor = tint
                imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            }
            imageView.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
            iconView = imageView
        case .error(let image, let tintColor):
            let image = image ?? UIImage(named: "error")!
            var imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
            if let tint = tintColor {
                imageView.tintColor = tint
                imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            }
            imageView.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
            iconView = imageView
        case .info:
            iconView = nil // info 不需要图标
        case .custom(let image, let tintColor):
            var imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
            if let tint = tintColor {
                imageView.tintColor = tint
                imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            }
            imageView.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
            iconView = imageView
        }
        
        if let icon = iconView {
            stackView.addArrangedSubview(icon)
        }
        
        // --- 文字视图 ---
        if let text = text, !text.isEmpty {
            let label = UILabel()
            label.text = text
            label.font = configuration.textFont
            label.textColor = configuration.textColor
            label.numberOfLines = 0
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        if style == .info {
            NSLayoutConstraint.activate([
                box.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                box.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -50),
                box.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor, multiplier: 0.8),
                box.widthAnchor.constraint(greaterThanOrEqualTo: stackView.widthAnchor, constant: 24)
            ])
        }else{
            NSLayoutConstraint.activate([
                box.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                box.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            ])
        }
        
        hudView = container
        
        // 动画
        UIView.animate(withDuration: configuration.animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseInOut],
                       animations: {
            container.alpha = 1
            container.transform = .identity
        })
        
        if let duration, style != .loading {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.hideHUD()
            }
        }
    }

    
    private func hideHUD() {
        UIView.animate(withDuration: configuration.animationDuration,
                       animations: {
            self.hudView?.alpha = 0
        }, completion: { _ in
            self.hudView?.removeFromSuperview()
            self.hudView = nil
            self.isShowing = false
            self.displayNextIfNeeded()
        })
    }
    
    public static func topMostView() -> UIView {
        guard let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            fatalError("找不到可用的窗口")
        }
        return window
    }
}

extension Bundle {
    static let xxhud: Bundle = {
        return Bundle.module
    }()
}
extension UIImage {
    static func xxhud(named name: String) -> UIImage {
        return UIImage(named: name, in: .xxhud, compatibleWith: nil) ?? UIImage()
    }
}

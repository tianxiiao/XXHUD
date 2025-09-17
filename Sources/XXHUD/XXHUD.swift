import UIKit

@MainActor
public class XXHUDManager {
    public static let shared = XXHUDManager()
    
    private var hudView: UIView?
    private var hudQueue: [(view: UIView, text: String?, style: HUDStyle, duration: TimeInterval?)] = []
    private var isShowing = false
    
    public var configuration = HUDConfiguration()
    
    private init() {}
    
    // MARK: - 添加 HUD
    public func enqueue(in view: UIView, text: String?, style: HUDStyle, duration: TimeInterval?) {
        hudQueue.append((view, text, style, duration))
        displayNextIfNeeded()
    }
    
    public func hide() {
        hideHUD()
    }
    
    // MARK: - 队列管理
    private func displayNextIfNeeded() {
        guard !isShowing, !hudQueue.isEmpty else { return }
        isShowing = true
        let next = hudQueue.removeFirst()
        showHUD(in: next.view, text: next.text, style: next.style, duration: next.duration)
    }
    
    // MARK: - 显示 HUD
    private func showHUD(in view: UIView, text: String?, style: HUDStyle, duration: TimeInterval?) {
        // 移除旧 HUD
        hudView?.removeFromSuperview()
        
        let container = UIView(frame: view.bounds)
        container.backgroundColor = configuration.containerBackgroundColor
        container.alpha = 0
        container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        let box = UIView()
        box.backgroundColor = configuration.boxBackgroundColor
        box.layer.cornerRadius = configuration.cornerRadius
        box.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(box)
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            box.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            box.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            box.widthAnchor.constraint(equalToConstant: configuration.defaultHUDSize.width),
            box.heightAnchor.constraint(equalToConstant: configuration.defaultHUDSize.height)
        ])
        
        // 内容视图
        let contentView: UIView
        switch style {
        case .loading:
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.startAnimating()
            contentView = indicator
        case .success:
            let label = UILabel()
            label.text = "✔︎"
            label.font = .systemFont(ofSize: 50)
            label.textColor = .green
            label.textAlignment = .center
            contentView = label
        case .error:
            let label = UILabel()
            label.text = "✖︎"
            label.font = .systemFont(ofSize: 50)
            label.textColor = .red
            label.textAlignment = .center
            contentView = label
        case .info:
            let label = UILabel()
            label.text = "ℹ︎"
            label.font = .systemFont(ofSize: 50)
            label.textColor = configuration.textColor
            label.textAlignment = .center
            contentView = label
        case .custom(let image, let tintColor):
            let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            if let tint = tintColor { imageView.tintColor = tint }
            imageView.contentMode = .scaleAspectFit
            contentView = imageView
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        box.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: box.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: box.centerYAnchor)
        ])
        
        // 保存 HUD
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
        
        // 自动消失
        if let duration = duration {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.hideHUD()
            }
        }
    }
    
    private func hideHUD() {
        UIView.animate(withDuration: configuration.animationDuration,
                       animations: {
            self.hudView?.alpha = 0
            self.hudView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            self.hudView?.removeFromSuperview()
            self.hudView = nil
            self.isShowing = false
            self.displayNextIfNeeded()
        })
    }
}

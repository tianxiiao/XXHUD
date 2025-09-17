import UIKit

public struct HUDConfiguration {
    public var cornerRadius: CGFloat = 12
    public var boxBackgroundColor: UIColor = UIColor(white: 0, alpha: 0.8)
    public var containerBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    public var shadowColor: UIColor = .black
    public var shadowOpacity: Float = 0.3
    public var shadowOffset: CGSize = CGSize(width: 2, height: 2)
    public var shadowRadius: CGFloat = 6
    public var textColor: UIColor = .white
    public var textFont: UIFont = .systemFont(ofSize: 14, weight: .medium)
    public var animationDuration: TimeInterval = 0.25
    public var defaultHUDSize: CGSize = CGSize(width: 80, height: 80)
    
    public init() {}
}

import UIKit

public enum HUDStyle {
    case loading
    case success(image: UIImage? = nil, tintColor: UIColor? = nil)
    case error(image: UIImage? = nil, tintColor: UIColor? = nil)
    case info
    case custom(image: UIImage, tintColor: UIColor? = nil)
}

import UIKit

public enum HUDStyle {
    case loading
    case success
    case error
    case info
    case custom(image: UIImage, tintColor: UIColor? = nil)
}

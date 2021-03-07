
import UIKit

extension UIView {
    
    func getShadow(color: CGColor = UIColor.black.cgColor, offset: CGSize = CGSize(width: -5, height: -5), opacity: Float = 0.5, radius: CGFloat = 5) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.opacity = 0.7
        
    }
}

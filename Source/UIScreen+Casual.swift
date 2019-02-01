import UIKit

extension UIScreen {
    // Shape of the screen
    // Changes if you rotate the device
    public var ratio: Float {
        return Float(self.bounds.size.width / self.bounds.size.height)
    }
}

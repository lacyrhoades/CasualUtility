import UIKit

extension CGSize {
    public var half: CGSize {
        return CGSize(
            width: floor(self.width / 2.0),
            height: floor(self.height / 2.0)
        )
    }

    public static func * (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }

    public static var greatestFiniteMagnitude: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }

    public init(width: Float, height: Float) {
        self.init(width: CGFloat(width), height: CGFloat(height))
    }
}


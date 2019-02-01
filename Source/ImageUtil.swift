import UIKit

public struct ImageRenderUtil {
    public static var rendererQueue = DispatchSemaphore(value: 1)
    public static var rendererCache = NSCache<NSString, UIGraphicsImageRenderer>()
    public static func renderer(forSize size: CGSize) -> UIGraphicsImageRenderer {
        rendererQueue.wait()

        if let existing = ImageRenderUtil.rendererCache.object(forKey: size.rendererCacheKey) {
            rendererQueue.signal()
            return existing
        }

        let config = UIGraphicsImageRendererFormat()
        config.opaque = true
        config.prefersExtendedRange = false
        config.scale = 1.0
        let renderer = UIGraphicsImageRenderer(size: size, format: config)
        ImageRenderUtil.rendererCache.setObject(renderer, forKey: size.rendererCacheKey)
        rendererQueue.signal()
        return renderer
    }
}

extension CGSize {
    var rendererCacheKey: NSString {
        return "\(self.width)x\(self.height)" as NSString
    }
}


import UIKit

extension UIImage {
    public func imageByCropping(withZoom z: CGFloat, offset o: CGPoint) -> UIImage {
        let origin = o |> invert()
        return self.size |> CGRect.init |> zoom(by: z) |> offset(by: origin) |> self.draw(withSize: self.size)
    }
    
    public func imageByCropping(toFrame cropFrame: CGRect) -> UIImage {
        let delta = cropFrame.origin |> invert()
        return self.size |> CGRect.init |> offset(by: delta) |> self.draw(withSize: cropFrame.size)
    }
    
    private func draw(withSize drawSize: CGSize) -> (CGRect) -> (UIImage) {
        return {
            UIGraphicsBeginImageContextWithOptions(drawSize, false, self.scale)
            self.draw(in: $0)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result ?? self
        }
    }
}

extension UIImage {
    public func imageByNormalizingOrientation() -> UIImage {
        guard self.imageOrientation != .up else {
            return self
        }

        let size = self.size;

        UIGraphicsBeginImageContextWithOptions(size, false, self.scale);

        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext();

        return normalizedImage!
    }

    public func imageResizedTo(maxSize: CGSize) -> UIImage {
        let maxResultWidth: CGFloat = maxSize.width // 720
        let maxResultHeight: CGFloat = maxSize.height // 960
        let maxRatio = maxResultWidth / maxResultHeight // 1.77777777

        var scaledWidth = maxResultWidth
        var scaledHeight = maxResultHeight

        let naturalRatio = self.size.width / self.size.height // 1.333333333

        if maxRatio >= naturalRatio {
            scaledHeight = maxResultHeight // fit to height
            scaledWidth = ceil(scaledHeight * naturalRatio) // fit to width
        } else {
            scaledWidth = maxResultWidth // fit to width
            scaledHeight = ceil(scaledWidth / naturalRatio)
        }

        let xOffset: CGFloat = floor((maxResultWidth - scaledWidth) / 2.0)
        let yOffset: CGFloat = floor((maxResultHeight - scaledHeight) / 2.0)

        UIGraphicsBeginImageContextWithOptions(maxSize, false, 1.0);
        self.draw(in: CGRect(x: xOffset, y: yOffset, width: scaledWidth, height: scaledHeight))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return resultImage!
    }
    
    public func imageInside(cropSize: CGSize, backgroundColor: UIColor, yOffset: Float = 0.5) -> UIImage {
        var scaledSize: CGSize
        
        var dx: CGFloat = 0
        var dy: CGFloat = 0
        
        if self.ratio > cropSize.ratio {
            // fit width
            let ratio = cropSize.width / self.size.width
            scaledSize = CGSize(width: cropSize.width, height: cropSize.height * ratio)
            dy = CGFloat(cropSize.height - scaledSize.height) * CGFloat(yOffset)
        } else {
            // fit height
            let ratio = cropSize.height / self.size.height
            scaledSize = CGSize(width: cropSize.width * ratio, height: cropSize.height)
            dx = CGFloat(cropSize.width - scaledSize.width) * CGFloat(yOffset)
        }
        
        return ImageRenderUtil.renderer(forSize: cropSize).image(actions: { (context) in
            context.cgContext.setFillColor(backgroundColor.cgColor)
            context.cgContext.fill(CGRect(size: cropSize))
            self.draw(in: CGRect(x: dx, y: dy, width: CGFloat(scaledSize.width), height: CGFloat(scaledSize.height)))
        })
    }
    
    public func imageInside(ratio: Float, backgroundColor: UIColor) -> UIImage {
        var outputSize: CGSize
        
        var dx: CGFloat = 0
        var dy: CGFloat = 0
        
        if self.size.height > self.size.width {
            outputSize = CGSize(width: floor(Float(self.size.height) * ratio), height: Float(self.size.height))
            dx = (outputSize.width - self.size.width) / 2.0
        } else {
            outputSize = CGSize(width: self.size.width, height: floor(self.size.width / CGFloat(ratio)))
            dy = (outputSize.height - self.size.height) / 2.0
        }
        
        return ImageRenderUtil.renderer(forSize: outputSize).image { (context) in context.cgContext.setFillColor(backgroundColor.cgColor)
            context.cgContext.fill(CGRect(size: outputSize))
            self.draw(in: CGRect(x: dx, y: dy, width: self.size.width, height: self.size.height))
        }
    }

    public func imageCroppedToFitInside(ratio: Float, backgroundColor: UIColor, yOffset: Float) -> UIImage {
        return self.imageInside(cropSize: CGSize(width: self.size.height * CGFloat(ratio), height: self.size.height), backgroundColor: backgroundColor, yOffset: yOffset)
    }

    public func imageCroppedToFitInside(cropSize: CGSize, backgroundColor: UIColor? = nil) -> UIImage {
        let xOffset: CGFloat = floor((self.size.width - cropSize.width) / 2.0)
        let yOffset: CGFloat = floor((self.size.height - cropSize.height) / 2.0)

        UIGraphicsBeginImageContextWithOptions(CGSize(width: cropSize.width, height: cropSize.height), false, self.scale)

        if let color = backgroundColor {
            UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
            UIGraphicsGetCurrentContext()?.fill(CGRect(origin: .zero, size: cropSize))
        }

        self.draw(in: CGRect(x: -1 * xOffset, y: -1 * yOffset, width: self.size.width, height: self.size.height))

        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return croppedImage!
    }

    public func imageCenterCroppedTo(cropSize: CGSize) -> UIImage {
        guard cropSize != self.size else {
            return self
        }
        
        let cropWidth: CGFloat = cropSize.width
        let cropHeight: CGFloat = cropSize.height

        let cropRatio = cropWidth / cropHeight

        let naturalRatio = self.size.width / self.size.height

        var scaledWidth = cropWidth
        var scaledHeight = cropHeight

        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0

        if cropRatio > naturalRatio {
            // fit width
            scaledHeight = scaledWidth / naturalRatio
            yOffset = -1 * abs(scaledHeight - cropHeight) / 2.0
        } else {
            // fit height
            scaledWidth = scaledHeight * naturalRatio
            xOffset = -1 * abs(scaledWidth - cropWidth) / 2.0
        }

        return ImageRenderUtil.renderer(forSize: cropSize).image { (context) in
            self.draw(in: CGRect(x: xOffset, y: yOffset, width: ceil(scaledWidth), height: ceil(scaledHeight)))
        }
    }

    public func imageResizedToFit(ratio: CGFloat) -> UIImage {
        if self.size.width > self.size.height {
            return self.imageResizedToFit(boundingBox: CGSize(width: self.size.width, height: self.size.height * ratio))
        } else {
            return self.imageResizedToFit(boundingBox: CGSize(width: self.size.width * ratio, height: self.size.height))
        }

    }

    public func imageResizedToFit(boundingBox: CGSize) -> UIImage {
        if self.size.height <= boundingBox.height && self.size.width <= boundingBox.width {
            return self
        }

        let boundingWidth: CGFloat = boundingBox.width     // 1920
        let boundingHeight: CGFloat = boundingBox.height   // 1080
        let boundingRatio = boundingWidth / boundingHeight // val > 1 is considered "wide"

        let naturalRatio = self.size.width / self.size.height

        var scaledHeight = boundingHeight
        var scaledWidth = boundingWidth

        if boundingRatio > naturalRatio {
            // fit to bounding height
            scaledWidth = scaledWidth * naturalRatio
        } else {
            // fit to bounding width
            scaledHeight = scaledHeight / naturalRatio
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: scaledWidth, height: scaledHeight), false, self.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: floor(scaledWidth), height: floor(scaledHeight)))

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();

        return result!
    }
    
    public func madeHorizontal() -> UIImage {
        if self.ratio >= 1.0 {
            return self
        }
        
        let size = CGSize(width: self.size.height, height: self.size.width)
        
        return ImageRenderUtil.renderer(forSize: size).image(actions: {
            context in
            // context.cgContext.translateBy(x: 100, y: 100)
            context.cgContext.rotate(by: CGFloat.pi / 2.0)
            self.draw(in: CGRect(x: 0, y: -1 * self.size.height, width: self.size.width, height: self.size.height))
        })
    }

    public func politelyCenterCroppedTo(ratio: Float) -> UIImage {
        switch (ratio > 1.0, self.ratio > 1.0) {
        case (true, true):
            return self.centerCroppedTo(ratio: ratio)
        case (true, false):
            return self.centerCroppedTo(ratio: 1.0 / ratio)
        case (false, true):
            return self.centerCroppedTo(ratio: 1.0 / ratio)
        case (false, false):
            return self.centerCroppedTo(ratio: ratio)
        }
    }
    
    public func centerCroppedTo(ratio: Float) -> UIImage {
        var height: CGFloat
        var width: CGFloat

        let naturalRatio = self.size.width / self.size.height
        let cropRatio = CGFloat(ratio)

        if cropRatio >= naturalRatio {
            // fit width
            width = self.size.width
            height = ceil(width / cropRatio)
        } else {
            // fit height
            height = self.size.height
            width = ceil(height * cropRatio)
        }

        let xOffset: CGFloat = -1 * (abs(width - self.size.width) / 2.0)
        let yOffset: CGFloat = -1 * (abs(height - self.size.height) / 2.0)

        return ImageRenderUtil.renderer(forSize: CGSize(width: width, height: height)).image { (context) in
            self.draw(in: CGRect(x: xOffset, y: yOffset, width: self.size.width, height: self.size.height))
        }
    }

    public func imageByFlippingHorizontal() -> UIImage {
        let size = self.size;

        UIGraphicsBeginImageContextWithOptions(size, false, self.scale);

        let context = UIGraphicsGetCurrentContext()

        context?.translateBy(x: size.width, y: 0)

        context?.scaleBy(x: -1.0, y: 1.0)

        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let img = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext();

        return img!
    }
    
    public func image(byOverlayingImage overlay: UIImage) -> UIImage {

        let size = self.size
        let overlaySize = overlay.size

        var scale: CGFloat

        if size.height > size.width {
            scale = size.width / overlaySize.width
        } else {
            scale = size.height / overlaySize.height
        }

        let scaledSize = CGSize(width: overlaySize.width * scale, height: overlaySize.height * scale)

        let xOffset = (size.width - scaledSize.width) / 2.0
        let yOffset = (size.height - scaledSize.height) / 2.0

        let selfRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let scaledOverlayRect = CGRect(x: xOffset, y: yOffset, width: scaledSize.width, height: scaledSize.height)

        return ImageRenderUtil.renderer(forSize: size).image(actions: {
            context in
            self.draw(in: selfRect)
            overlay.draw(in: scaledOverlayRect)
        })
    
    }
    
    public func rotated(_ radians: CGFloat) -> UIImage {
        
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        
        let t = CGAffineTransform(rotationAngle: radians);
        
        rotatedViewBox.transform = t
        
        let rotatedSize = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        
        let bitmap = UIGraphicsGetCurrentContext()!
        
        bitmap.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        bitmap.rotate(by: radians);
        
        bitmap.scaleBy(x: 1.0, y: -1.0)
        
        let drawRect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
        
        bitmap.draw(self.cgImage!, in: drawRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    public func imageByRepeating(_ times: Int) -> UIImage {
        var outputSize: CGSize

        if size.width > size.height {
            outputSize = size |> multiplyHeight(by: CGFloat(times))
        } else {
            outputSize = size |> multiplyWidth(by: CGFloat(times))
        }

        UIGraphicsBeginImageContextWithOptions(outputSize, false, self.scale);

        var origin = CGRect(size: self.size)
        var x: CGFloat = 0
        var y: CGFloat = 0

        for i: Int in 0...(times - 1) {
            if size.width > size.height {
                y = size.height * CGFloat(i)
            } else {
                x = size.width * CGFloat(i)
            }
            origin = CGRect(x: x, y: y, width: size.width, height: size.height)
            self.draw(in: origin)
        }

        let img = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext();

        return img!
    }

    public static func imageFrom(color: UIColor, size: CGSize? = nil) -> UIImage? {
        let size = size ?? CGSize(width: 1, height: 1)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    public func imageByNudging(by nudge: CGPoint) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, true, self.scale);
        self.draw(in: CGRect(x: nudge.x, y: nudge.y, width: self.size.width, height: self.size.height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return resultImage!
    }

    public static func pickSelects(count: Int, fromImages images: [UIImage]) -> [UIImage] {
        if images.count < count {
            return images
        }

        let idealStep: Int = images.count / count

        if images.count < idealStep * count {
            return Array(images.prefix(count))
        }

        var results: [UIImage] = []
        for i in 0...(count - 1) {
            results.append(images[i * idealStep])
        }
        return results
    }
}

extension UIImage {
    public var ratio: Float {
        return Float(self.size.width / self.size.height)
    }
}

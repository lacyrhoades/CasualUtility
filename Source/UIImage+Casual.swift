//
//  UIImage+Casual.swift
//  ImageEditing
//
//  Created by Lacy Rhoades on 4/18/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

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

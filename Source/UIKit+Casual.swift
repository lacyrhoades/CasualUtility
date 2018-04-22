//
//  UIKit+Casual.swift
//  ImageEditing
//
//  Created by Lacy Rhoades on 4/18/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

import UIKit

extension CGPoint {
    public init(size: CGSize) {
        self.init(x: size.width, y: size.height)
    }
    
    public init(_ float: CGFloat) {
        self.init(x: float, y: float)
    }
    
    public static var one: CGPoint {
        return CGPoint(x: 1, y: 1)
    }
    
    public static var half: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
}

extension CGRect {
    public init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
}

extension CGAffineTransform {
    public init(scale val: CGFloat) {
        self.init(scaleX: val, y: val)
    }
    public init(translate size: CGPoint) {
        self.init(translationX: size.x, y: size.y)
    }
}

//
//  Functions.swift
//  ImageEditing
//
//  Created by Lacy Rhoades on 4/18/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

import UIKit

public func add(_ point: CGPoint) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x + point.x,
            $0.y + point.y
            ) |> CGPoint.init
    }
}

public func add(_ size: CGSize) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x + size.width,
            $0.y + size.height
        ) |> CGPoint.init
    }
}

public func subtract(_ point: CGPoint) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x - point.x,
            $0.y - point.y
            ) |> CGPoint.init
    }
}

public func subtract(_ size: CGSize) -> (CGSize) -> CGSize {
    return {
        (
            $0.width - size.width,
            $0.height - size.height
        ) |> CGSize.init
    }
}

public func multiply(by scalar: CGFloat?) -> (CGSize) -> CGSize {
    return {
        (
            $0.width * (scalar ?? 1),
            $0.height * (scalar ?? 1)
        ) |> CGSize.init
    }
}

public func floor() -> (CGPoint) -> CGPoint {
    return {
        (
            floor($0.x),
            floor($0.y)
        ) |> CGPoint.init
    }
}


public func multiply(by size: CGSize?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x * (size?.width ?? 1),
            $0.y * (size?.height ?? 1)
        ) |> CGPoint.init
    }
}

public func multiply(by size: CGSize?) -> (CGSize) -> CGSize {
    return {
        (
            $0.width * (size?.width ?? 1),
            $0.width * (size?.height ?? 1)
            ) |> CGSize.init
    }
}

public func multiply(by point: CGPoint?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x * (point?.x ?? 1),
            $0.y * (point?.y ?? 1)
            ) |> CGPoint.init
    }
}

public func divide(by scalar: CGFloat?) -> (CGSize) -> CGSize {
    return {
        (
            $0.width / (scalar ?? 1),
            $0.height / (scalar ?? 1)
        ) |> CGSize.init
    }
}

public func multiply(by scalar: CGFloat?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x * (scalar ?? 1),
            $0.y * (scalar ?? 1)
        ) |> CGPoint.init
    }
}

public func divide(by scalar: CGFloat?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x / (scalar ?? 1),
            $0.y / (scalar ?? 1)
        ) |> CGPoint.init
    }
}


public func offset(by distance: CGPoint?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x + (distance?.x ?? 0),
            $0.y + (distance?.y ?? 0)
        ) |> CGPoint.init
    }
}

public func divide(by: CGPoint) -> (CGPoint) -> CGPoint {
    return  {
        (
            $0.x / by.x,
            $0.y / by.y
        ) |> CGPoint.init
    }
}

public func divide(by: CGSize) -> (CGPoint) -> CGPoint {
    return  {
        (
            $0.x / by.width,
            $0.y / by.height
        ) |> CGPoint.init
    }
}

public func invert() -> (CGSize) -> CGSize {
    return {
        $0 |> multiply(by: -1)
    }
}

public func invertY() -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x,
            $0.y * -1
        ) |> CGPoint.init
    }
}

public func invert() -> (CGPoint) -> CGPoint {
    return {
        $0 |> multiply(by: -1)
    }
}

public func half() -> (CGSize) -> CGSize {
    return {
        $0 |> divide(by: 2)
    }
}

public func centerPoint() -> (CGSize) -> CGPoint {
    return {
        $0 |> CGPoint.init |> divide(by: 2)
    }
}

func zoom(by scalar: CGFloat?) -> (CGRect) -> CGRect {
    return {
        (
            $0.size
                |> multiply(by: scalar)
                |> subtract($0.size)
                |> invert()
                |> half()
                |> CGPoint.init,
            $0.size
                |> multiply(by: scalar)
        ) |> CGRect.init
    }
}

func offset(by distance: CGPoint?) -> (CGRect) -> CGRect {
    return {
        (
            $0.origin |> offset(by: distance),
            $0.size
        ) |> CGRect.init
    }
}


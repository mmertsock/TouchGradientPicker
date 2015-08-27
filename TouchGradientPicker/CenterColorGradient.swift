//
//  CenterColorGradient.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public struct CenterColorGradient: GradientType {

    // The color at the "midpoint" of the gradient
    public let centerColor: UIColor

    // The amount by which to shift the hue of the centerColor at each
    // "endpoint" of the gradient. Negative values permitted
    public let hueVariance: CGFloat
    
    public var colorPoints: [(CGFloat, UIColor)] {
        get {
            return [(0, startColor), (0.5, centerColor), (1, endColor)]
        }
    }
    
    public var startColor: UIColor {
        return centerColor.colorWithHueComponent(centerColor.hue - hueVariance)
    }
    
    public var endColor: UIColor {
        return centerColor.colorWithHueComponent(centerColor.hue + hueVariance)
    }
    
    public init(centerColor: UIColor, hueVariance: CGFloat) {
        self.centerColor = centerColor
        self.hueVariance = hueVariance
    }
}

public extension CenterColorGradient {
    public init(flatColor: UIColor) {
        centerColor = flatColor
        hueVariance = 0
    }
}

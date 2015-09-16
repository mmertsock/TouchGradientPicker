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
    
    // The amount by which to shift the saturation of the centerColor at
    // each "endpoint" of the gradient. Negative values permitted
    public let satVariance: CGFloat
    
    // The amount by which to shift the brightness of the centerColor at
    // each "endpoint" of the gradient. Negative values permitted
    public let brightnessVariance: CGFloat
    
    // The amount by which to shift the opacity of the centerColor at
    // each "endpoint" of the gradient. Negative values permitted
    public let alphaVariance: CGFloat
    
    public var colorPoints: [(CGFloat, UIColor)] {
        get {
            return [(0, startColor), (0.5, centerColor), (1, endColor)]
        }
    }
    
    public var startColor: UIColor {
        return makeColor(-1)
    }
    
    public var endColor: UIColor {
        return makeColor(1)
    }
    
    private func makeColor(factor: CGFloat) -> UIColor {
        let (h, s, b, a) = centerColor.getHSBAComponents()
        return UIColor(
            hue: h + factor * hueVariance,
            saturation: s + factor * satVariance,
            brightness: b + factor * brightnessVariance,
            alpha: a + factor * alphaVariance)
    }
    
    // TODO why do we have to manually write this ctor
    
    public init(centerColor: UIColor, hueVariance: CGFloat, satVariance: CGFloat, brightnessVariance: CGFloat, alphaVariance: CGFloat) {
        self.centerColor = centerColor
        self.hueVariance = hueVariance
        self.satVariance = satVariance
        self.brightnessVariance = brightnessVariance
        self.alphaVariance = alphaVariance
    }
}

public extension CenterColorGradient {
    public init(flatColor: UIColor) {
        centerColor = flatColor
        hueVariance = 0
        satVariance = 0
        brightnessVariance = 0
        alphaVariance = 0
    }
}

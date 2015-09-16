//
//  CenterColorGradientBuilder.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public class CenterColorGradientBuilder: GradientBuilder {

    public private(set) var currentValue: CenterColorGradient
    
    public struct CenterColorBuilderParams {
        public var hue: ((Pan, CGFloat) -> CGFloat)?
        public var saturation: ((Pan, CGFloat) -> CGFloat)?
        public var brightness: ((Pan, CGFloat) -> CGFloat)?
        public var alpha: ((Pan, CGFloat) -> CGFloat)?
        func colorFromPan(pan: Pan, panStartValue: UIColor) -> UIColor {
            let (h, s, b, a) = panStartValue.getHSBAComponents()
            let newHue = hue?(pan, h)
            let newSaturation = saturation?(pan, s)
            let newBrightness = brightness?(pan, b)
            let newAlpha = alpha?(pan, a)
            return UIColor(
                hue: newHue ?? h,
                saturation: newSaturation ?? s,
                brightness: newBrightness ?? b,
                alpha: newAlpha ?? a)
        }
    }
    
    public var centerColor = CenterColorBuilderParams()
    
    public var hueVariance: ((Pan, CGFloat) -> CGFloat)?
    
    public var satVariance: ((Pan, CGFloat) -> CGFloat)?
    
    public var brightnessVariance: ((Pan, CGFloat) -> CGFloat)?
    
    public var alphaVariance: ((Pan, CGFloat) -> CGFloat)?
    
    public init(initialValue: CenterColorGradient) {
        currentValue = initialValue
    }
    
    public func gradientFromPan(pan: Pan, panStartValue: GradientType) -> GradientType {
        let panStartValue = (panStartValue as? CenterColorGradient) ?? currentValue
        var newCenterColor = centerColor.colorFromPan(pan, panStartValue: panStartValue.centerColor)
        var newHueVariance = hueVariance?(pan, panStartValue.hueVariance)
        var newSatVariance = satVariance?(pan, panStartValue.satVariance)
        var newBrightnessVariance = brightnessVariance?(pan, panStartValue.brightnessVariance)
        var newAlphaVariance = alphaVariance?(pan, panStartValue.alphaVariance)
        currentValue = CenterColorGradient(
            centerColor: newCenterColor,
            hueVariance: newHueVariance ?? panStartValue.hueVariance,
            satVariance: newSatVariance ?? panStartValue.satVariance,
            brightnessVariance: newBrightnessVariance ?? panStartValue.brightnessVariance,
            alphaVariance: newAlphaVariance ?? panStartValue.alphaVariance)
        return currentValue
    }
}

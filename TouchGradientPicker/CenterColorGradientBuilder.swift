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
        func colorFromPan(pan: Pan, panStartValue: UIColor) -> UIColor {
            if let newHue = hue?(pan, panStartValue.hue) {
                return panStartValue.colorWithHueComponent(newHue)
            }
            return panStartValue
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

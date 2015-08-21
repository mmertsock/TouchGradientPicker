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
        func colorFromPan(pan: Pan, currentValue: UIColor) -> UIColor {
            if let newHue = hue?(pan, currentValue.hue) {
                return currentValue.colorWithHueComponent(newHue)
            }
            return currentValue
        }
    }
    
    public var centerColor = CenterColorBuilderParams()
    
    public var hueVariance: ((Pan, CGFloat) -> CGFloat)? // = identity()
    
    public init(initialValue: CenterColorGradient) {
        currentValue = initialValue
    }
    
    public func gradientFromPan(pan: Pan) -> GradientType {
        var newCenterColor = centerColor.colorFromPan(pan, currentValue: currentValue.centerColor)
        var newHueVariance = hueVariance?(pan, currentValue.hueVariance)
        currentValue = CenterColorGradient(
            centerColor: newCenterColor,
            hueVariance: newHueVariance ?? currentValue.hueVariance)
        return currentValue
    }
}

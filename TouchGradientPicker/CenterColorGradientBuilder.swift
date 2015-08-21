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
    
    public var hueVariance: (Pan, CGFloat) -> CGFloat = identity()
    
    public init(initialValue: CenterColorGradient) {
        currentValue = initialValue
    }
    
    public func gradientFromPan(pan: Pan) -> GradientType {
        var newHueVariance = hueVariance(pan, currentValue.hueVariance)
        currentValue = CenterColorGradient(centerColor: currentValue.centerColor, hueVariance: newHueVariance)
        return currentValue
    }
}

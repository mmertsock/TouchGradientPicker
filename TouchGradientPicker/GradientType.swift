//
//  GradientType.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public protocol GradientType {
    // Defines colors at points along the abstract length 
    // or radius of a gradient. The float values should be 
    // between 0 and 1, inclusive.
    var colorPoints: [(CGFloat, UIColor)] { get }
}

public extension UIView {
    public func fillWithGradient(gradientParams: GradientType, context: CGContext!) {
        let CGColors = gradientParams.colorPoints.map { $0.1.CGColor }
        // TODO respect the point values
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), CGColors, nil)
        
        let bounds = self.bounds
        let startPoint = CGPointMake(bounds.midX, bounds.minY)
        let endPoint = CGPointMake(bounds.midX, bounds.maxY)
        let opts = CGGradientDrawingOptions(kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, opts)
    }
}

//
//  UIColorExtensions.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

extension UIColor {
    func getHSBAComponents() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    func colorWithHueComponent(newHue: CGFloat) -> UIColor {
        var (_, s, b, a) = getHSBAComponents()
        var clampedHue = newHue
        if clampedHue > 1 { clampedHue = clampedHue - floor(newHue) }
        if clampedHue < 0 { clampedHue = clampedHue + ceil(abs(newHue)) }
        let newColor = UIColor(hue: clampedHue, saturation: s, brightness: b, alpha: a)
        return newColor
    }
    
    func colorWithBrightnessComponent(newBrightness: CGFloat) -> UIColor {
        var (h, s, _, a) = getHSBAComponents()
        return UIColor(hue: h, saturation: s, brightness: newBrightness, alpha: a)
    }
    
    func colorWithSaturationComponent(newSaturation: CGFloat) -> UIColor {
        var (h, _, b, a) = getHSBAComponents()
        return UIColor(hue: h, saturation: newSaturation, brightness: b, alpha: a)
    }
    
    var hue: CGFloat {
        var (h, _, _, _) = getHSBAComponents()
        return h
    }
}

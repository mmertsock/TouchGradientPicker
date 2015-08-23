//
//  ViewController.swift
//  TouchGradientPickerDemo
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit
import TouchGradientPicker

class ViewController: UIViewController {
    
    // Storyboard:
    // Add a UIView with custom class GradientView
    // Add a UIView with custom class TouchGradientPicker
    // Set up outlets from this view controller to the two views
    // Set up an outlet from the TouchGradientPicker to the GradientView

    // The two views can have identical size and position if you want the
    // gestures to cover the full area of the gradient, or they can be 
    // laid out independently in any way you wish.
    
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var picker: TouchGradientPicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the gradient view and builder
        
        let initialCenter = UIColor(hue: 0.9, saturation: 0.45, brightness: 0.86, alpha: 1)
        let initialValue = CenterColorGradient(centerColor: initialCenter, hueVariance: 0.09)
        gradientView.gradient = initialValue

        let builder = CenterColorGradientBuilder(initialValue: initialValue)

        // Horizontal pan gestures: change the average hue of the gradient
        
        builder.centerColor.hue = {
            pan, currentValue in
            // Square the value so small swipes = smaller adjustments, 
            // for easier fine adjustment.
            var newHue = currentValue + pan.horizontal * pan.horizontal * (pan.horizontal < 0 ? -1 : 1)
            return newHue
        }

        // Vertical pan gestures: change the "spread" of the gradient
        
        let maxHueVarianceMagnitude: CGFloat = 0.35 // Cap the maximum amount of hue variance
        builder.hueVariance = clamp({
            pan, currentValue in
            // Reverse the direction of the swipe
            currentValue + pan.scaled(-maxHueVarianceMagnitude).vertical
        }, -maxHueVarianceMagnitude, maxHueVarianceMagnitude)
        
        picker.gradientBuilder = builder
    }
}

func clamp<T: Comparable>(valueFunc: (Pan, T) -> T, minValue: T, maxValue: T) -> (Pan, T) -> T {
    return {
        pan, value in
        let newValue = valueFunc(pan, value)
        return max(minValue, min(maxValue, newValue))
    }
}

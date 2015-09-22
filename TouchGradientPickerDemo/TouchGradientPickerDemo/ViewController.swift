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
        initializeGradientBuilder(0)
    }
    
    private func initializeGradientBuilder(mode: Int) {
        switch (mode) {
        case 0: setUpHueHueVarianceBuilder()
        case 1: setUpSatAlphaVarianceBuilder()
        default: break
        }
    }
    
    private func setUpHueHueVarianceBuilder() {
        demoExplanationLabel.text = "Swipe L/R to change hue, U/D to change hue variance"
        
        // Initialize the gradient view and builder
        
        let initialCenter = UIColor(hue: 0.9, saturation: 0.45, brightness: 0.86, alpha: 1)
        let initialValue = CenterColorGradient(centerColor: initialCenter, hueVariance: 0.09, satVariance: 0, brightnessVariance: 0, alphaVariance: 0)
        gradientView.gradient = initialValue
        
        let builder = CenterColorGradientBuilder(initialValue: initialValue)
        
        // Horizontal pan gestures: change the average hue of the gradient
        
        builder.centerColor.hue = {
            pan, currentValue in
            // Square the value so small swipes = smaller adjustments,
            // for easier fine adjustment.
            let newHue = currentValue + pan.horizontal * pan.horizontal * (pan.horizontal < 0 ? -1 : 1)
            return newHue
        }
        
        // Vertical pan gestures: change the "spread" of the gradient
        
        let maxHueVarianceMagnitude: CGFloat = 0.35 // Cap the maximum amount of hue variance
        builder.hueVariance = clamp({
            pan, currentValue in
            // Reverse the direction of the swipe
            currentValue + pan.scaled(-maxHueVarianceMagnitude).vertical
            }, minValue: -maxHueVarianceMagnitude, maxValue: maxHueVarianceMagnitude)
        
        picker.gradientBuilder = builder
    }
    
    private func setUpSatAlphaVarianceBuilder() {
        demoExplanationLabel.text = "Swipe L/R to change saturation, U/D to change contrast"
        
        // Initialize the gradient view and builder
        
        let centerHue: CGFloat = 0.64
        let initialCenter = UIColor(hue: centerHue, saturation: 0.5, brightness: 0.6, alpha: 0.7)
        let initialValue = CenterColorGradient(centerColor: initialCenter, hueVariance: 0, satVariance: 0, brightnessVariance: -0.2, alphaVariance: 0)
        gradientView.gradient = initialValue
        
        let builder = CenterColorGradientBuilder(initialValue: initialValue)
        
        // Horizontal pan gestures: change the average saturation of the gradient
        
        builder.centerColor.saturation = {
            pan, currentValue in
            // Reverse the direction of the swipe
            currentValue - pan.horizontal
        }
        
        // Vertical pan gestures: vary the brightness AND alpha at either end of the gradient
        
        let maxBrightnessVarianceMagnitude: CGFloat = 0.4 // Cap the maximum amount of contrast
        builder.brightnessVariance = clamp({
            pan, currentValue in
            currentValue + pan.scaled(maxBrightnessVarianceMagnitude).vertical
            }, minValue: -maxBrightnessVarianceMagnitude, maxValue: maxBrightnessVarianceMagnitude)
        
        let maxAlphaVarianceMagnitude: CGFloat = 0.3
        builder.alphaVariance = clamp({
            pan, currentValue in
            currentValue + pan.scaled(maxAlphaVarianceMagnitude).vertical
            }, minValue: -maxAlphaVarianceMagnitude, maxValue: maxAlphaVarianceMagnitude)
        
        // Keep the hue pegged at a single value
        // (extreme brightness/saturation values can cause the original hue to be lost)
        builder.centerColor.hue = { pan, currentValue in centerHue }
        
        picker.gradientBuilder = builder
    }
    
    // Outlets and actions for playing with the demo
    
    @IBOutlet var demoExplanationLabel: UILabel!
    @IBAction func builderSetupSelected(segmentedControl: UISegmentedControl!) {
        initializeGradientBuilder(segmentedControl.selectedSegmentIndex)
    }
}

func clamp<T: Comparable>(valueFunc: (Pan, T) -> T, minValue: T, maxValue: T) -> (Pan, T) -> T {
    return {
        pan, value in
        let newValue = valueFunc(pan, value)
        return max(minValue, min(maxValue, newValue))
    }
}

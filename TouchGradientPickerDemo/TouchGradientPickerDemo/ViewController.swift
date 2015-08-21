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
    
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var picker: TouchGradientPicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let initialCenter = UIColor(hue: 0.9, saturation: 0.45, brightness: 0.86, alpha: 1)
        let initialValue = CenterColorGradient(centerColor: initialCenter, hueVariance: 0.09)
        gradientView.gradient = initialValue

        let builder = CenterColorGradientBuilder(initialValue: initialValue)

        builder.centerColor.hue = {
            pan, currentValue in
            var newHue = currentValue + pan.horizontal * pan.horizontal
            return newHue
        }

        let maxHueVarianceMagnitude: CGFloat = 0.35
        builder.hueVariance = clamp({
            pan, currentValue in
            currentValue + pan.scaled(-maxHueVarianceMagnitude).vertical
        }, -maxHueVarianceMagnitude, maxHueVarianceMagnitude)
        
        picker.gradientBuilder = builder
    }
}

func clamp<T: Comparable>(operand: (Pan, T) -> T, minValue: T, maxValue: T) -> (Pan, T) -> T {
    return {
        pan, value in
        let newValue = operand(pan, value)
        return max(minValue, min(maxValue, newValue))
    }
}

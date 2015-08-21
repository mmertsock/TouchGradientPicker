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
        let initialValue = CenterColorGradient(centerColor: UIColor.greenColor(), hueVariance: 0.2)
        gradientView.gradient = initialValue

        let builder = CenterColorGradientBuilder(initialValue: initialValue)

        builder.centerColor.hue = {
            pan, currentValue in
            var newHue = currentValue + pan.normalizedDistance.x
            return newHue
        }
        
        builder.hueVariance = {
            pan, currentValue in
            max(-0.5, min(0.5, currentValue + pan.normalizedDistance.y))
        }
        
        picker.gradientBuilder = builder
    }
}

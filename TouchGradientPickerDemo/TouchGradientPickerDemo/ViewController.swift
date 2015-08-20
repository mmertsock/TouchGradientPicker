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

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.gradient = CenterColorGradient(centerColor: UIColor.greenColor(), hueVariance: 0.2)
    }
}

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

//
//  CenterColorGradient.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public struct CenterColorGradient: GradientType {

    public let centerColor: UIColor
    public let hueVariance: CGFloat
    
    public var colorPoints: [(CGFloat, UIColor)] {
        get {
            // TODO proper implementation
            return [(0, centerColor), (1, centerColor)]
        }
    }
    
}

public extension CenterColorGradient {
    public init(flatColor: UIColor) {
        centerColor = flatColor
        hueVariance = 0
    }
}

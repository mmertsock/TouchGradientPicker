//
//  GradientView.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public class GradientView: UIView {
    public var gradient: GradientType = CenterColorGradient(flatColor: UIColor.blackColor()) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func drawRect(rect: CGRect) {
        fillWithGradient(gradient, context: UIGraphicsGetCurrentContext())
        super.drawRect(rect)
    }
}

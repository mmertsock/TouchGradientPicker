//
//  GradientBuilder.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/20/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public protocol GradientBuilder {
    func gradientFromPan(pan: Pan) -> GradientType
}

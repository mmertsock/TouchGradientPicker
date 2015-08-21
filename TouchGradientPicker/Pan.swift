//
//  Pan.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/20/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public struct Pan {
    // values in the range [-1, 1], describes the amount of distance the
    // user swiped relative to the size of the containing view.
    // A value of 1 means the user swiped all the way to the right or down,
    // a value of -1 means the user swiped all the way to the left or down,
    // 0.25 means the user swiped 1/4 the distance.
    public let horizontal: CGFloat
    public let vertical: CGFloat
    
    public func scaled(factor: CGFloat) -> Pan {
        return Pan(horizontal: factor * horizontal, vertical: factor * vertical)
    }
}

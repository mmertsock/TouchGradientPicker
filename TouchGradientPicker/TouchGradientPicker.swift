//
//  TouchGradientPicker.swift
//  TouchGradientPicker
//
//  Created by Mike Mertsock on 8/19/15.
//  Copyright (c) 2015 Esker Apps. All rights reserved.
//

import UIKit

public class TouchGradientPicker: UIView {

    @IBOutlet var gradientView: GradientView!
    
    public var gradientBuilder: GradientBuilder?
    private var panStartValue: GradientType?
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpGestureRecognizers()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpGestureRecognizers()
    }
    
    private func setUpGestureRecognizers() {
        let recognizer = UIPanGestureRecognizer(target: self, action: "didPan:")
        addGestureRecognizer(recognizer)
    }
    
    func didPan(sender: UIPanGestureRecognizer!) {
        switch (sender.state) {
        case .Began:
            panStartValue = gradientView.gradient
        case .Changed:
            if let pan = panFromGesture(sender),
                newGradient = gradientBuilder?.gradientFromPan(pan, panStartValue: panStartValue ?? gradientView.gradient) {
                gradientView.gradient = newGradient
            }
        case .Ended:
            panStartValue = nil
        default:
            break
        }
    }
    
    func panFromGesture(gesture: UIPanGestureRecognizer) -> Pan? {
        let viewTx = gesture.translationInView(self)
        
        // normalize both directions to [-1, 1]
        let panBounds = bounds
        if panBounds.width < 1 || panBounds.height < 1 {
            return nil
        }
        
        let normalized = CGPointMake(viewTx.x / panBounds.width, viewTx.y / panBounds.height)
        
        return Pan(normalizedDistance: normalized)
    }
}

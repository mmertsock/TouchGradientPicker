# TouchGradientPicker [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

TouchGradientPicker is a UIKit framework for displaying and editing color gradients.

- Render gradients with a simple UIView subclass and a couple lines of code
- Build a customized control for editing gradients
- Gradient picker uses no sliders or buttons: all input is gesture-based for an analog, organic feel; you can build a beautiful full-screen picker
- 100% Swift, iOS 8 required
- Abstract API, extensible via subclassing and functional programming
- Flexible layout options: gradient display and editor input are separate views that can be laid however you please, in IB or programmatically

TouchGradientPicker was developed for and featured in [Dayly Calendar][]. See the [app preview video][video], at about 18 seconds in, for a quick demo.

You can also bookmark/favorite TouchGradientPicker on [CocoaControls][].

## GradientView: display color gradients in a simple UIView

A simple UIView subclass that draws a gradient background, by setting the value of the `gradient` property. Drop this onto your storyboard scene in Xcode with whatever layout you want.

## GradientType: abstract value types that model gradients

The `GradientType` protocol defines a list of color-position pairs. Each color is associated with a float value between 0 and 1. These values place the color points along the length of the gradient, and the color at each point along the gradient is determined by interpolating the adjacent colors. See [`CGGradient` reference][CGGradient] for more info.

Implementations of GradientType provide various ways to construct gradients. The single implementation currently provided, `CenterColorGradient`, describes a gradient by defining the color to display at the “center” of the gradient, and the amount by which to shift various components of that color at each endpoint of the gradient.

You can build your own implementation of GradientType as well.

## TouchGradientPicker

This is a lightweight UIView that translates gesture-based inputs into transformations on a GradientType, which are applied to a corresponding GradientView. To use this control, add both a GradientView and TouchGradientPicker to your storyboard, connect the outlet from the picker to the GradientView, and you'll likely want some outlets connecting your view controller to these views.

In `viewDidLoad` or another appropriate place, you need to configure the picker by setting the `gradientBuilder` property. Classes conforming to the `GradientBuilder` protocol act as a delegate for the picker, producing new GradientTypes based on user gestures.

Currently the single available builder is `CenterColorGradientBuilder`, which produces `CenterColorGradient` objects. Create an instance of this class and initialize with a default gradient value. Assign this to the `gradientBuilder` property of the picker.

### CenterColorGradientBuilder

In addition to creating an object of this class and assigning it to the picker object, you need to configure how it reacts to the user's pan gestures. You assign one or more properties on the builder object, such as `hueVariance` or `centerColor.hue`. You assign blocks that take the current value and `Pan` gesture data as input, and return a new hue/color/etc. value. For example, you may wish to have horizontal pan gestures result in a positive/negative shift in the average hue of the gradient.

## Demo

See the [demo code][] for a concrete, runnable example of TouchGradientPicker usage and gradient builder setup.

[Dayly Calendar]: http://www.esker-apps.com/dayly/
[video]: http://www.esker-apps.com/dayly/demo/
[CocoaControls]: https://www.cocoacontrols.com/controls/touchgradientpicker
[CGGradient]: https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CGGradient/index.html
[demo code]: https://github.com/mmertsock/TouchGradientPicker/blob/master/TouchGradientPickerDemo/TouchGradientPickerDemo/ViewController.swift

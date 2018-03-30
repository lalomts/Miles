//
//  NSColorExtensions.swift
//  Miles
//
//  Created by Lalo Martínez on 3/28/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AppKit

public typealias ColorPalette = (background: NSColor, colors: [NSColor])

extension NSColor {
  
  public static let originalMiles: ColorPalette = (
    background: NSColor(displayP3Red: 0.16697396618029117, green: 0.19278033402949113, blue: 0.24439306972789115, alpha: 1.0),
  colors:[
    NSColor(displayP3Red: 0.9647058823529412, green: 0.7372549019607844, blue: 0.1137254901960785, alpha: 1.0),
    NSColor(displayP3Red: 0.9686274509803922, green: 0.1294117647058823, blue: 0.1294117647058823, alpha: 1.0),
    NSColor(displayP3Red: 0.07450980392156856, green: 0.9176470588235294, blue: 0.5490196078431373, alpha: 1.0),
    NSColor(displayP3Red: 0.7019607843137254, green: 0.1411764705882352, blue: 0.6549019607843135, alpha: 1.0),
    NSColor(displayP3Red: 0.8901960784313725, green: 0.8509803921568627, blue: 0.6078431372549019, alpha: 1.0),
    NSColor(displayP3Red: 0.3568627450980396, green: 0.2392156862745099, blue: 0.8627450980392157, alpha: 1.0),
    NSColor(displayP3Red: 0.9411764705882353, green: 0.3803921568627451, blue: 0.2666666666666667, alpha: 1.0),
    NSColor(displayP3Red: 0.1372549019607845, green: 0.07843137254901965, blue: 0.8509803921568627, alpha: 1.0)
  ])
  
  public static let purpleRain: ColorPalette = (
    background: NSColor(displayP3Red: 0.27058823529411763, green: 0.007843137254901973, blue: 0.3568627450980392, alpha: 1.0),
    colors: [
      NSColor(displayP3Red: 0.5098039215686275, green: 0.01960784313725494, blue: 0.6745098039215687, alpha: 1.0),
     NSColor(displayP3Red: 1, green: 0.03529411764705881, blue: 0.15294117647058836, alpha: 1.0),
     NSColor(displayP3Red: 0.35686274509803956, green: 0.23921568627450987, blue: 0.8627450980392157, alpha: 1.0),
     NSColor(displayP3Red: 0.031372549019607836, green: 0.2941176470588236, blue: 0.3058823529411765, alpha: 1.0),
     NSColor(displayP3Red: 0.807843137254902, green: 0.9607843137254902, blue: 0.192156862745098, alpha: 1.0),
     NSColor(displayP3Red: 1, green: 0.9450980392156862, blue: 0.796078431372549, alpha: 1.0),
     ]
  )
  
  public static let ramboSunshine: ColorPalette = (
    background: NSColor(displayP3Red: 0.07450980392156865, green: 0.3333333333333333, blue: 0.2705882352941176, alpha: 1.0),
    colors:
    [NSColor(displayP3Red: 0.2705882352941176, green: 0.9254901960784314, blue: 0.30980392156862757, alpha: 1.0),
     NSColor(displayP3Red: 0.403921568627451, green: 0.5137254901960784, blue: 0.11372549019607844, alpha: 1.0),
     NSColor(displayP3Red: 0.15294117647058822, green: 0.5686274509803921, blue: 0.5372549019607843, alpha: 1.0),
     NSColor(displayP3Red: 1, green: 0.9450980392156862, blue: 0.796078431372549, alpha: 1.0),
     NSColor(displayP3Red: 1, green: 0.9294117647058824, blue: 0.207843137254902, alpha: 1.0),
     NSColor(displayP3Red: 1, green: 0, blue: 0.1294117647058819, alpha: 1.0),
     NSColor(displayP3Red: 0.9647058823529412, green: 0.7372549019607844, blue: 0.11372549019607846, alpha: 1.0),
     ]
  )
  
}

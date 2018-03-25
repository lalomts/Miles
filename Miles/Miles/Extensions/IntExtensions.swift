//
//  IntExtensions.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation

extension Int {
  
  public var uint32: UInt32 {
    return UInt32(self)
  }
  
  public var uint8: UInt8 {
    return UInt8(self)
  }
  
  public static func randomWith(floor: Int = 0, ceil: Int) -> Int{
    let realCeil = ceil - floor + 1
    return Int(arc4random_uniform(UInt32(realCeil)) + UInt32(floor))
  }
}

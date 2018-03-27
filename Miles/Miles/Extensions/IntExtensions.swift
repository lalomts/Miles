//
//  IntExtensions.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation

extension Int {
  
  /// Returns the Int value as a `UInt32`
  public var uint32: UInt32 {
    return UInt32(self)
  }
  
  /// Returns the Int value as a `UInt8`
  public var uint8: UInt8 {
    return UInt8(self)
  }
  
  /// Creates a random Int between the specified floor and ceiling.
  ///
  /// - Parameters:
  ///   - floor: The bottom limit for the random number *(default is 0)*
  ///   - ceil: The upper limit for the random number
  /// - Returns: The random number generated
  public static func randomWith(floor: Int = 0, ceil: Int) -> Int{
    let realCeil = ceil - floor + 1
    return Int(arc4random_uniform(UInt32(realCeil)) + UInt32(floor))
  }
}

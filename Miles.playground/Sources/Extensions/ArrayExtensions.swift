//
//  ArrayExtensions.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation

extension Array {
  
  /// Returns the index of the last element in the array.
  var maxIndex: Int {
    return self.count - 1
  }
  
  /// Returns a random element from the array.
  ///
  /// - Returns: The random element
  func randomElement() -> Element {
    return self[Int.randomWith(ceil: self.maxIndex)]
  }

}

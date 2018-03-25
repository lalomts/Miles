//
//  ArrayExtensions.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation

extension Array {
  
  var maxIndex: Int {
    return self.count - 1
  }
  
  func randomElement() -> Element {
    return self[Int.randomWith(ceil: self.maxIndex)]
  }

}

//
//  Visualizable.swift
//  Miles
//
//  Created by Lalo Martínez on 3/28/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import SpriteKit

public protocol Drawable {
  
  var canvas: MilesCanvas? { get set }
  
  var draws: Bool { get }
  
}

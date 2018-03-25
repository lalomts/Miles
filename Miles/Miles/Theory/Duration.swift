//
//  Duration.swift
//  Miles
//
//  Created by Lalo Martínez on 3/22/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public enum Duration: Float {
  
  case whole = 4 // Semibreve
  case half = 2 // Minim
  case quarter = 1 // Crotchet
  case eighth = 0.5 // Quaver
  case sixteenth = 0.25 // Semiquaver
  case thirtySecond = 0.125 // Demisemiquaver
  case sixtyFourth = 0.0625 // Hemidemisemiquaver
  // And so on...

  //TODO: - Add triplet
  
  public var dotted:Float {
    return self.rawValue + (self.rawValue / 2)
  }
  
  static func randomize(_ durations: [Duration]) -> Duration{
    return durations.randomElement()
  }
}

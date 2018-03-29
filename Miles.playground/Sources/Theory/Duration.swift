//
//  Duration.swift
//  Miles
//
//  Created by Lalo Martínez on 3/22/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public enum Duration {
  
  case whole(dotted: Bool)
  case half(dotted: Bool)
  case quarter(dotted: Bool)
  case eighth(dotted: Bool)
  case sixteenth(dotted: Bool)
  case thirtySecond(dotted: Bool)
  case sixtyFourth(dotted: Bool)
  case eightTriplet(thirds: Float)
  
  
  /// The value (in beats) for the specified duration.
  public var value: Float {
    switch self {
    case .whole(let dotted): return calculateValue(duration: 4, dotted: dotted) // Semibreve
    case .half(let dotted): return calculateValue(duration: 2, dotted: dotted)  // Minim
    case .quarter(let dotted): return calculateValue(duration: 1, dotted: dotted) // Crotchet
    case .eighth(let dotted): return calculateValue(duration: 0.5, dotted: dotted)  // Quaver
    case .sixteenth(let dotted): return calculateValue(duration: 0.25, dotted: dotted) // Semiquaver
    case .thirtySecond(let dotted): return calculateValue(duration: 0.125, dotted: dotted) // Demisemiquaver
    case .sixtyFourth(let dotted): return calculateValue(duration: 0.0625, dotted: dotted) // Hemidemisemiquaver
    case .eightTriplet(thirds: let t): return t * (1/3) //Eighth note triplet
    }
  }
 
  /// The value (in beats) for the specified duration as a `Double`
  public var valueDouble: Double {
    return Double(self.value)
  }
  
  private func calculateValue(duration: Float, dotted: Bool) -> Float {
    return dotted ? duration * 1.5 : duration
  }

  static func randomize(_ durations: [Duration]) -> Duration{
    return durations.randomElement()
  }
}

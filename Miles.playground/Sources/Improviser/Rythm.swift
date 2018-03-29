//
//  Rythm.swift
//  Miles
//
//  Created by Lalo Martínez on 3/25/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public enum Rythm {
  
  public typealias Pattern = [RythmBlock]
  
  case Comping
  case Bassline
  case DrumBeat(part: DrumSwinger.DrumPart)
  
  public enum RythmBlock {
    case note(Duration)
    case rest(Duration)
  }
  
  public var pattern: Pattern {
    switch self {
    case .Comping: return randomComping()
    case .Bassline: return randomBassline()
    case .DrumBeat(part: let part): return randomDrumPart(part: part)
    }
  }
  
  /// Creates a random rythm pattern for comping one bar.
  ///
  /// - Returns: The note/rest rythm pattern for the bar
  private func randomComping() -> Pattern {
    let rythms: [Pattern] = [
      [.note(.quarter(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.half(dotted: false))],
      
      [.rest(.quarter(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.eighth(dotted: false)), .note(.quarter(dotted: false)), .rest(.eighth(dotted: false))],
      
      [.rest(.half(dotted: false)), .note(.quarter(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false))],
     
      [.rest(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.quarter(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.quarter(dotted: false))],
      
      [.rest(.eighth(dotted: false)), .note(.quarter(dotted: true)), .note(.quarter(dotted: false)), .rest(.quarter(dotted: false))],
      
      [.note(.eighth(dotted: false)), .note(.quarter(dotted: false)), .note(.eighth(dotted: false)), .rest(.half(dotted: false))],
      
      [.rest(.quarter(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.quarter(dotted: false))],
      
      [.rest(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.eighth(dotted: false)), .rest(.half(dotted: false))],
      
      [.note(.quarter(dotted: false)), .rest(.quarter(dotted: false)), .note(.quarter(dotted: false)), .rest(.quarter(dotted: false))],
      
      [.rest(.quarter(dotted: false)), .note(.quarter(dotted: false)),.rest(.quarter(dotted: false)), .note(.quarter(dotted: false))],
      
      [.note(.half(dotted: false)), .note(.eighth(dotted: false)), .note(.eighth(dotted: false)), .rest(.quarter(dotted: false))],
      
      [.note(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.quarter(dotted: false)), .rest(.half(dotted: false)) ],
      
      [.note(.half(dotted: false)), .note(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.quarter(dotted: false))],
      
      [.note(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.half(dotted: false)), .rest(.eighth(dotted: false)), .note(.eighth(dotted: false))]
    ]
    return rythms.randomElement()
  }
  
  /// Creates a random bassline pattern that can be used inside a bar
  ///
  /// - Returns: Returns: The note/rest rythm pattern for the bar
  private func randomBassline() -> Pattern {
    let rythms: [Pattern] = [
      [.note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.quarter(dotted: false)) ],
      [.note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .note(.quarter(dotted: false)) ]

    ]
    return rythms.randomElement()
  }
  /// Creates a random drumline pattern that can be used inside a bar, divided by drum parts (hihats, bass, etc.)
  ///
  /// - Returns: Returns: The note/rest rythm pattern for the selected drum part
  private func randomDrumPart(part: DrumSwinger.DrumPart) -> Pattern {
    
    let ride: [Pattern] = [
      [.note(.quarter(dotted: false)), .note(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .note(.quarter(dotted: false)), .note(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1))],
      
      [.note(.eightTriplet(thirds: 1)),.rest(.eightTriplet(thirds: 1)),.note(.eightTriplet(thirds: 1)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .note(.quarter(dotted: false)),.note(.eightTriplet(thirds: 1)),.rest(.eightTriplet(thirds: 1)),.note(.eightTriplet(thirds: 1)) ],

      [.note(.quarter(dotted: false)),
       .note(.eightTriplet(thirds: 1)),.rest(.eightTriplet(thirds: 1)),.note(.eightTriplet(thirds: 1)),
       .note(.eightTriplet(thirds: 1)),.rest(.eightTriplet(thirds: 1)),.note(.eightTriplet(thirds: 1)),
       .note(.eightTriplet(thirds: 1)),.rest(.eightTriplet(thirds: 1)),.note(.eightTriplet(thirds: 1))]
    ]
    
    let hihats: [Pattern] = [
      [.rest(.quarter(dotted: false)), .note(.quarter(dotted: false)), .rest(.quarter(dotted: false)), .note(.quarter(dotted: false))],
      
      [.rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.quarter(dotted: false)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.quarter(dotted: false))]
    ]
    
    let bassDrum: [Pattern] = [
      [.note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.quarter(dotted: false))  ],
      
      [.note(.quarter(dotted: false)), .rest(.quarter(dotted: false)), .note(.quarter(dotted: false)), .rest(.quarter(dotted: false))  ],
      
    ]
    
    let snare: [Pattern] = [
      [.rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.quarter(dotted: false))],
      
      [.rest(.quarter(dotted: false)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.half(dotted: false))],
      
      [.rest(.half(dotted: false)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)) ],
      
      [.rest(.quarter(dotted: false)), .note(.eightTriplet(thirds: 1)), .note(.eightTriplet(thirds: 1)), .rest(.eightTriplet(thirds: 1)), .rest(.eightTriplet(thirds: 2)), .note(.eightTriplet(thirds: 1)), .rest(.quarter(dotted: false))],
    ]
  
    switch part {
    case .ride:
      
      return ride.randomElement()
    case .hihats:
      return hihats.randomElement()
    case .bass:
      return bassDrum.randomElement()
    case .snare:
      return snare.randomElement()
    }
  }
}

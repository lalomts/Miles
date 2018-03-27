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
  case DrumBeat
  case Bassline
  
  public enum RythmBlock {
    case note(Duration)
    case rest(Duration)
  }
  
  public var pattern: Pattern {
    switch self {
    case .Comping: return randomComping()
    case .Bassline: return randomBassline()
    default:
      return []
    }
  }
  
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
  
  private func randomBassline() -> Pattern {
    let rythms: [Pattern] = [
      [.note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.quarter(dotted: false)), .note(.quarter(dotted: false)) ],
//      [.note(.quarter), .note(.quarter), .note(.quarter), .note(.quarter) ],
//      [.note(.quarter), .note(.quarter), .note(.quarter), .rest(.sixteenth), .note(.sixteenth), .note(.eighth)],
//      [.note(.quarter), .note(.eighth), .note(.eighth), .note(.quarter), .note(.quarter)]
    ]
    return rythms.randomElement()
  }
  
}

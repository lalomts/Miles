//
//  Rythm.swift
//  Miles
//
//  Created by Lalo Martínez on 3/25/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public enum Rythm {
  
  case Comping
  case DrumBeat
  case Bassline
  
  public enum RythmBlock {
    case note(Duration)
    case rest(Duration)
  }
  
  public var pattern: [RythmBlock] {
    switch self {
    case .Comping: return randomComping()
    case .Bassline: return randomBassline()
    default:
      return []
    }
  }
  
  private func randomComping() -> [RythmBlock] {
    let rythms: [[RythmBlock]] = [
      [.note(.quarter), .rest(.eighth), .note(.eighth), .rest(.half)],
      [.rest(.quarter), .rest(.eighth), .note(.eighth), .rest(.eighth), .note(.quarter), .rest(.eighth)],
      [.rest(.half), .note(.quarter), .rest(.eighth), .note(.eighth)],
      [.rest(.quarter), .rest(.eighth), .note(.eighth), .note(.quarter), .note(.quarter)],
      [.rest(.eighth), .note(.eighth), .rest(.quarter), .rest(.eighth), .note(.eighth), .rest(.quarter)],
      [.note(.eighth), .note(.quarter), .note(.eighth), .rest(.half)],
      [.rest(.quarter), .rest(.eighth), .note(.eighth), .rest(.eighth), .note(.eighth), .rest(.quarter)],
      [.rest(.quarter), .note(.quarter), .note(.eighth), .rest(.half)],
      [.note(.quarter), .rest(.quarter), .note(.quarter), .rest(.quarter)],
      [.rest(.quarter), .note(.quarter),.rest(.quarter), .note(.quarter)],
      [.note(.half), .note(.eighth), .note(.eighth), .rest(.quarter)],
    ]
    return rythms.randomElement()
  }
  
  private func randomBassline() -> [RythmBlock] {
    let rythms: [[RythmBlock]] = [
      [.note(.quarter), .note(.quarter), .note(.quarter), .note(.quarter) ],
//      [.note(.quarter), .note(.quarter), .note(.quarter), .note(.quarter) ],
//      [.note(.quarter), .note(.quarter), .note(.quarter), .rest(.sixteenth), .note(.sixteenth), .note(.eighth)],
//      [.note(.quarter), .note(.eighth), .note(.eighth), .note(.quarter), .note(.quarter)]
    ]
    return rythms.randomElement()
  }
  
}

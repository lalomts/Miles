//
//  Scale.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//
import Foundation

public enum Scale: Int {
  case major
  case minor
  case harmonicMinor
  case melodicMinor
  case majorPentatonic
  case minorPentatonic
  case majorBebop
  case minorBebop
  case bebopDominant
  case augmented
  case dorian
  case phrygian
  case lydian
  case mixolydian
  case aeolian
  case locrian
  case blues
  case spanishGypsy
  
  public func tones(forKey fundamental: Tone) -> [Tone] {
    return self.intervals.map{ fundamental.noteAtInterval($0) }
  }
  
  public var intervals: [Interval] {
    switch self {
    case .major: return [.P1, .M2, .M3, .P4, .P5, .M6, .M7]
    case .minor: return [.P1, .M2, .m3, .P4, .P5, .m6, .m7]
    case .harmonicMinor: return [.P1, .M2, .m3, .P4, .P5, .m6, .M7]
    case .melodicMinor: return [.P1, .M2, .m3, .P4, .P5, .M6, .M7]
    case .majorPentatonic: return [.P1, .M2, .M3, .P5, .M6]
    case .minorPentatonic: return [.P1, .m3, .P4, .P5, .m7]
    case .majorBebop: return [.P1, .M2, .M3, .P4, .P5, .m6, .M6, .M7]
    case .minorBebop: return [.P1, .M2, .m3, .P4, .P5, .m6, .M6, .M7]
    case .bebopDominant: return [.P1, .M2, .M3, .P4, .P5, .M6, .m7, .M7]
    case .dorian: return [.P1, .M2, .m3, .P4, .P5, .M6, .m7]
    case .phrygian: return [.P1, .m2, .m3, .P4, .P5, .m6, .m7]
    case .lydian: return [.P1, .M2, .M3, .d5, .P5, .M6, .M7]
    case .mixolydian: return [.P1, .M2, .M3, .P4, .P5, .M6, .m7]
    case .aeolian: return [.P1, .M2, .m3, .P4, .P5, .m6, .m7]
    case .locrian: return [.P1, .m2, .m3, .P4, .d5, .m6, .m7]
    case .blues: return [.P1, .m3, .P4, .d5, .P5, .m7]
    case .spanishGypsy: return [.P1, .m2, .M3, .P4, .P5, .m6, .m7]
    case .augmented: return [.P1, .m3, .M3, .P5, .m6, .M7]
    }
  }
  
  public static var count: Int {
    var maxValue: Int = 0
    while let _ = Scale(rawValue: maxValue) {
      maxValue += 1
    }
    return maxValue
  }
  
  public static func random() -> Scale {
    let rand = Int.randomWith(ceil: Scale.count)
    return Scale(rawValue: rand)!
  }
  
}


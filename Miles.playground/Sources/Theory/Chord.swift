//
//  Chord.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation

public enum ChordQuality: String {
  
  case Maj7
  case M7s5
  case min7
  case m7b5
  case dim7
  case dom7
  case sus4
  
  public var intervals: [Interval] {
    switch self {
    case .Maj7: return [.P1, .M3, .P5, .M7]
    case .M7s5: return [.P1, .M3, .m6, .M7]
    case .min7: return [.P1, .m3, .P5, .m7]
    case .m7b5: return [.P1, .m3, .d5, .m7]
    case .dim7: return [.P1, .m3, .d5, .M6]
    case .dom7: return [.P1, .M3, .P5, .m7]
    case .sus4: return [.P1, .P4, .P5, .m7]
    }
  }
  
  public var improvScales: [Scale] {
    switch self {
    case .Maj7: return [.major, .lydian] + Scale.allMajor
    case .min7: return [.aeolian, .phrygian, .dorian, .blues] + Scale.allMinor
    case .m7b5: return [.locrian]
    case .dom7: return [.mixolydian, .lydian, .bebopDominant]
    case .sus4: return Scale.allMajor
    case .dim7: return [.diminished, .minorBebop]
    case .M7s5: return [.diminished, .minorBebop]
    }
  }
 
}

public enum ChordExtension {
  case m9
  case M9
  case A9
  case P11
  case A11
  case m13
  case M13
  
  public var interval: Interval {
    switch self {
    case .m9: return .m2
    case .M9: return .M2
    case .A9: return .m3
    case .P11: return .P4
    case .A11: return .d5
    case .m13: return .m6
    case .M13: return .M6
    }
  }
}

public struct Chord: CustomStringConvertible {
  
  public let root: Tone
  
  public let quality: ChordQuality
    
  public let extensions: [ChordExtension]
  
  public var tones: [Tone] {
    get {
      return quality.intervals.map{ root.noteAtInterval($0) }
    }
  }
  
  public func notes(atOctave octave:Int, inversion: Int = 0) -> [Note] {
    let notes = tones.map {Note( tone: $0, octave: self.root.index < $0.index ? octave : octave + 1 ) }
    let extns = extensions.map{ Note(tone: root.noteAtInterval($0.interval), octave: octave + 1) }
    var all = notes + extns
    
    //Shifts the chord's notes from octave to create a different voicing.
    if inversion > 0 {
      let inv = inversion < notes.count ? inversion : notes.count
      for i in 0...inv {
        all[i].octave += 1
      }
    }
    return all
  }
  
  public init(root: Tone, quality: ChordQuality, extensions: [ChordExtension] = []) {
    self.root = root
    self.quality = quality
    self.extensions = extensions
  }
  
  public var description: String {
    return "\(self.root)\(self.quality.rawValue)"
  }
  
}


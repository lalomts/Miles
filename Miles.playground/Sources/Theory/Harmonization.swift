//
//  Harmonization.swift
//  Miles
//
//  Created by Lalo Martínez on 3/24/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public struct Harmonization {
  
  public enum Degree {
    case I
    case II
    case III
    case IV
    case V
    case VI
    case VII
  }
  
  public enum HarmonizationType {
    case major
    case naturalMinor
    case melodicMinor
    case harmonicMinor
    
    /// The qualities for the chord at each of the scale's degrees.
    public var chordQualities: [ChordQuality] {
      switch self {
      case .major: return [.Maj7, .min7, .min7, .Maj7, .dom7, .min7, .m7b5]
      case .naturalMinor: return [.min7, .m7b5, .Maj7, .min7, .min7, .Maj7, .dom7]
      case .melodicMinor: return [.min7, .min7, .M7s5, .dom7, .dom7, .m7b5, .m7b5]
      case .harmonicMinor: return [.min7, .m7b5, .M7s5, .min7, .dom7, .Maj7, .dim7]
      }
    }
    
    public var scale: Scale {
      switch self {
      case .major: return .major
      case .naturalMinor: return .minor
      case .melodicMinor: return .melodicMinor
      case .harmonicMinor: return .harmonicMinor
      }
    }
  }
  
  public let chords: [Chord]
  public let scale: Scale
  public let key: Tone
  
  public init(key: Tone, type: HarmonizationType) {
    self.scale = type.scale
    self.key = key
    let scaleTones = type.scale.tones(forKey: key)
    let chordQualities = type.chordQualities
    
    var ch: [Chord] = []
    if scaleTones.count == type.chordQualities.count { // If the scale has the same elements as the qualities
      for i in 0...scaleTones.maxIndex {
        ch.append(Chord(root: scaleTones[i], quality: chordQualities[i]))
      }
    }
    self.chords = ch
  }
  
  
}

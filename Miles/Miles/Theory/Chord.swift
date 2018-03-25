//
//  Chord.swift
//  Miles
//
//  Created by Lalo Martínez on 3/23/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation

public enum ChordQuality {
  case Maj7
  case min7
  case m7b5
  case dim7
  case dom7
  case sus4
  
  public var intervals: [Interval] {
    
    switch self {
    case .Maj7: return [.P1, .M3, .P5, .M7]
    case .min7: return [.P1, .m3, .P5, .m7]
    case .m7b5: return [.P1, .m3, .d5, .m7]
    case .dim7: return [.P1, .m3, .d5, .M6]
    case .dom7: return [.P1, .M3, .P5, .m7]
    case .sus4: return [.P1, .P4, .P5, .m7]
      
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
  
  var interval: Interval {
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

public struct Chord {
  
  public let root: Tone
  
  public let octave: Int
  
  public let quality: ChordQuality
  
  public let extensions: [ChordExtension]
  
  public var tones: [Tone] {
    get {
      return quality.intervals.map{ root.noteAtInterval($0) }
    }
  }
  
  public var notes: [Note] {
    let notes = tones.map {Note( tone: $0, octave: self.root.index < $0.index ? octave : octave + 1 ) }
    let extns = extensions.map{ Note(tone: root.noteAtInterval($0.interval), octave: self.octave + 1) }
    return notes + extns
  }
  
  public func inversion(_ inversion: Int) -> [Note] {
    var notes = self.notes
    let inv = inversion < notes.count ? inversion : notes.count
    for i in 0...inv {
      notes[i].octave += 1
    }
    return notes
  }
  
  public init(root: Tone, octave: Int, quality: ChordQuality, extensions: [ChordExtension] = []) {
    self.root = root
    self.octave = octave
    self.quality = quality
    self.extensions = extensions
  }
  
}


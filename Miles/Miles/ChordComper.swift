//
//  ChordArpeggiator.swift
//  Miles
//
//  Created by Lalo Martínez on 3/25/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct ChordComper: Sequentiable {
  
  public let chord: Chord
  public let rythmPattern: [Rythm.RythmBlock]
  
  public init(chord: Chord) {
    self.chord = chord
    self.rythmPattern = Rythm.Comping.pattern
  }
  
  public func addToTrack(_ track: MusicTrack, onBeat beat: inout MusicTimeStamp) {
    
    for block in rythmPattern {
      
      switch block {
        
      case .note(let dur):
        
        for note in chord.notes(atOctave: Int.randomWith(floor: 2, ceil: 3), inversion: Int.randomWith(ceil: 2)) {
          note.addToTrack(track, onBeat: beat, duration: dur, velocity: Int.randomWith(floor: 30, ceil: 50))
        }
        
        beat += dur.rawValueDouble
      case .rest(let dur):
        beat += dur.rawValueDouble
      }
    }
  }
  
}

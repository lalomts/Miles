//
//  ChordArpeggiator.swift
//  Miles
//
//  Created by Lalo Martínez on 3/25/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// Arranges the chord's notes and inversions in a comping rythm to create the accompainment piano.
public struct ChordComper: Sequentiable {
  
  public let chord: Chord
  
  public init(chord: Chord) {
    self.chord = chord
  }
  
  public func addNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp) {
    
    let pattern = Rythm.Comping.pattern
    
    for block in pattern {
      
      switch block {
        
      case .note(let dur):
        
        for _ in 2...Int.randomWith(floor: 2, ceil: chord.tones.maxIndex) {//Use at least 2 notes to render chords
          let note = chord.notes(atOctave: Int.randomWith(floor: 1, ceil: 2), inversion: Int.randomWith(ceil: 2)).randomElement()
          note.addToTrack(track, onBeat: beat, duration: dur, velocity: Int.randomWith(floor: 30, ceil: 50))
        }
        
        
        beat += dur.valueDouble
      case .rest(let dur):
        beat += dur.valueDouble
      }
    }
  }
  
}

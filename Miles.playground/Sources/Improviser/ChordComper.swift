//
//  ChordArpeggiator.swift
//  Miles
//
//  Created by Lalo Martínez on 3/25/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// Arranges the chord's notes and inversions in a comping rythm to create the accompainment piano.
public struct ChordComper: Improviser {
  
  public var delegate: ImproviserDelegate?

  public func improviseNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp, basedOn harmony: Improviser.Harmony) {
    
    let chord = harmony.chord
    
    let pattern = Rythm.Comping.pattern
    
    for block in pattern {
      
      switch block {
        
      case .note(let dur):
        
        for _ in 2...Int.randomWith(floor: 2, ceil: chord.tones.maxIndex) {//Use at least 2 notes to render chords
          
          let note = chord.notes(atOctave: Int.randomWith(floor: 1, ceil: 2), inversion: Int.randomWith(ceil: 2)).randomElement()
          
          note.addToTrack(track, onBeat: beat, duration: dur, velocity: Int.randomWith(floor: 30, ceil: 50))
          
          self.delegate?.addedNote(withMidiValue: note.midiValue, atBeat: beat, withDuration: dur.valueDouble)
        }
        
        beat += dur.valueDouble
        
      case .rest(let dur):
        
        beat += dur.valueDouble
      }
    }
  }
  
}

//
//  Bassliner.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct Bassliner: Sequentiable {
  
  public let chord: Chord
  
  public let rythmPattern: Rythm.Pattern
  
  public init(chord: Chord) {
    self.chord = chord
    self.rythmPattern = Rythm.Bassline.pattern
  }
  
  public func addNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp) {
    
    var internalBeat: Float = 1
    
    for block in rythmPattern {
      
      switch block {
        
      case .note(let dur):
        let notes = chord.notes(atOctave: Int.randomWith(floor: 2, ceil: 3))
        var note: Note
        
        switch internalBeat {
        case 1 : note = notes.first{ $0.tone == chord.root }!
        case 3 : note = notes.first{ $0.tone == chord.tones[2] }!
        default: note = notes.randomElement()
        }
        note.addToTrack(track, onBeat: beat, duration: dur)
        
        internalBeat += dur.value
        beat += dur.valueDouble
        
      case .rest(let dur):
        beat += dur.valueDouble
      }
    }
  }
  
  
}

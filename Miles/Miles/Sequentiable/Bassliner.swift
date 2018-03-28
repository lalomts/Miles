//
//  Bassliner.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// Creates a walking baseline that works on top of a specified chord. 
public struct Bassliner: Improviser {
  
  public var delegate: ImproviserDelegate?
  
  public func improviseNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp, basedOn harmony: Improviser.Harmony) {

    var internalBeat: Float = 1
    
    for block in Rythm.Bassline.pattern {
      
      switch block {
        
      case .note(let dur):
        
        let notes = harmony.chord.notes(atOctave: 2)
        
        var note: Note
        
        switch internalBeat {
        case 1 : note = notes.first{ $0.tone == harmony.chord.root }!
        case 3 : note = notes.first{ $0.tone == harmony.chord.tones[2] }!
        default: note = notes.randomElement()
        }
        
        note.addToTrack(track, onBeat: beat, duration: dur)
        
        self.delegate?.addedNote(withMidiValue: note.midiValue, atBeat: beat, withDuration: dur.valueDouble)
        
        internalBeat += dur.value
        
        beat += dur.valueDouble
        
      case .rest(let dur):
        beat += dur.valueDouble
      }
    }
  }
}

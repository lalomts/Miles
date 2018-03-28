//
//  Soloer.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// Creates a melody line based on a random scale that works with each chord. 
public class Soloer: Improviser {
  
  public var delegate: ImproviserDelegate?
  
  public let canOverlapNotes: Bool
  
  public init(canOverlapNotes:Bool = true) {
    self.canOverlapNotes = canOverlapNotes
  }
  
  public func improviseNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp, basedOn harmony: Improviser.Harmony) {
  
    var internalBeat = MusicTimeStamp(0.0)
    
    var availableScales = harmony.chord.quality.improvScales
    
    availableScales.append(harmony.harmonization.scale)
    
    let improvScale = availableScales.randomElement()
    
    print("Will solo in \(harmony.harmonization.key)\(improvScale) over \(harmony.chord)")
    
    while internalBeat <= 4 {
      
      let durations: [Duration] = [.half(dotted: false), .quarter(dotted: false), .eighth(dotted: false)]
      
      if Int.randomWith(ceil: 5) != 0 { // 1/6 = probability of not having a note
        
        let duration = durations.randomElement()
        
        let realBeat = beat + internalBeat
        
        let note = Note.init(tone: improvScale.tones(forKey: harmony.harmonization.key).randomElement(),
                             octave: Int.randomWith(floor: 3, ceil: 4))
        
        note.addToTrack(track, onBeat: realBeat, duration: duration, velocity: Int.randomWith(floor: 40, ceil: 60))
        
        self.delegate?.addedNote(withMidiValue: note.midiValue, atBeat: realBeat, withDuration: duration.valueDouble)
        
        //If overlapping notes is permitted, advances a random duration, if not, advances the note's duration.
        internalBeat += canOverlapNotes ? durations.randomElement().valueDouble : duration.valueDouble
      } else {
        //If theres no note and should add a rest.
        internalBeat += durations.randomElement().valueDouble
      }
    }
    beat += 4
  }
}

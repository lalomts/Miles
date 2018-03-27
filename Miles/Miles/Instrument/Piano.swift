//
//  Piano.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct Piano: Instrument {
  
  public enum PianoType {
    case comping
    case soloing
  }
  
  public var sampler: Sampler
  
  public var type: PianoType
  
  public var volume: Float
  
  public init(for type: PianoType) {
    
    self.sampler  = Sampler(for: .piano)
    self.type = type
    self.volume = 1
  }
  
  public func createArrangementFor(progression: Sequence.Progression) {
    sampler.laySequence { (track) in
      var beat = MusicTimeStamp(0.0)
      for chordIndex in progression.steps {
        let arranger = ChordComper(chord: progression.harmonization.chords[chordIndex])
        arranger.addNotes(toTrack: track, onBeat: &beat)
      }
    }
  }
  
  public func play() {
    self.sampler.startPlaying()
  }
  
  public func stop() {
    self.sampler.stopPlaying()
  }
  
}


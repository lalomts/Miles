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
    
  public init(for type: PianoType, volume: Float = 1) {
    self.sampler  = Sampler(for: .piano)
    self.type = type
    self.sampler.volume = volume
  }
  
  public func createArrangementFor(progression: Sequence.Progression, atTempo tempo: Double) {
    sampler.laySequence(atTempo: tempo) { (track) in
      var beat = MusicTimeStamp(0.0)
      for chordIndex in progression.steps {
        let arranger: Sequentiable
        if self.type == .comping {
          arranger = ChordComper(chord: progression.harmonization.chords[chordIndex])
        } else {
          arranger = Soloer(harmonyInfo: (progression.harmonization, progression.harmonization.chords[chordIndex]))
        }
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


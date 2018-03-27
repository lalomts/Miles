//
//  Piano.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// A piano instrument that can be added to a sequence. It can be used to play a *comping rythm* or for *soloing.*
public struct Piano: Instrument {
  
  /// The purpose of the piano instrument (determines what type of music it will generate)
  ///
  /// - comping: Creates a comping rythm based on the harmonization chords
  /// - soloing: Creates a solo melody line using a scale that works on top of each chord in the progression
  public enum PianoType {
    case comping
    case soloing
  }
  
  public var sampler: Sampler
  
  public var type: PianoType
    
  /// Creates a new Piano instrument instance.
  ///
  /// - Parameters:
  ///   - type: A `PianoType` value indicating how the piano will generate the music.
  ///   - volume: The volume for the instrument *(should be between 0 and 1)*. Default is 1. 
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


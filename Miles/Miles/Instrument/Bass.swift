//
//  Bass.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// A bass instrument that can be added to a sequence. It creates a walking bassline on top of the sequence chords.
public struct Bass: Instrument {
  
  public var sampler: Sampler
  
  /// Creates a new bass instrument instance.
  ///
  /// - Parameter volume: The volume for the instrument *(should be between 0 and 1)*. Default is 1.
  public init(volume: Float = 1) {
    self.sampler = Sampler(for: .bass)
    self.sampler.volume = volume
  }
  
  public func createArrangementFor(progression: Sequence.Progression, atTempo tempo: Double) {
    sampler.laySequence(atTempo: tempo) { (track) in
      var beat = MusicTimeStamp(0.0)
      for chordIndex in progression.steps {
        
        let bassline = Bassliner(chord: progression.harmonization.chords[chordIndex])
        bassline.addNotes(toTrack: track, onBeat: &beat)
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

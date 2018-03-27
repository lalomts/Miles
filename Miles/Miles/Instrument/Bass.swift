//
//  Bass.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct Bass: Instrument {
  
  public var sampler: Sampler
  
  public var volume: Float
  
  public init() {
    self.sampler = Sampler(for: .bass)
    self.volume = 1
  }
  
  public func createArrangementFor(progression: Sequence.Progression) {
    sampler.laySequence { (track) in
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

//
//  Sax.swift
//  Miles
//
//  Created by Lalo Martínez on 3/27/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct Sax: Instrument {
  
  public var sampler: Sampler
  
  public init(volume: Float = 1) {
    self.sampler = Sampler(for: .sax)
    sampler.volume = volume
    
  }
  
  public func createArrangementFor(progression: Sequence.Progression, atTempo tempo: Double) {
    sampler.laySequence(atTempo: tempo) { (track) in
      var beat = MusicTimeStamp(0.0)
      for chordIndex in progression.steps {
        let arranger = Soloer(harmonyInfo: (progression.harmonization,      progression.harmonization.chords[chordIndex]),
                              availableDurations: [.half(dotted: false), .quarter(dotted: false)],
                              inOctaveRange: (3,4))

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

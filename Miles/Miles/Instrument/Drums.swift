//
//  Drums.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct Drums: Instrument {
  
  public var sampler: Sampler
  
  public var volume: Float
  
  private var arranger: DrumSwinger
  
  public init(withParts parts: Set<DrumSwinger.DrumPart>) {
    self.sampler = Sampler(for: .drums)
    self.arranger = DrumSwinger(withParts: parts)
    self.volume = 0.6
  }
  
  public func createArrangementFor(progression: Sequence.Progression) {
    self.sampler.laySequence { (track) in
      var beat = MusicTimeStamp(0.0)
      for _ in progression.steps {
        self.arranger.addNotes(toTrack: track, onBeat: &beat)
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

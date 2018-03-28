//
//  Drums.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox
import SpriteKit

/// A Drum Kit instrument that can be added to a sequence. It can use different drum elements like hihats, ride, snare and/or bass drum.
public class Drums: Instrument {  
  
  public var sampler: Sampler
  
  public let arranger: Improviser
  
  public var canvas: MilesCanvas?
  
  /// Creates a new Drums instance with the specified parts.
  ///
  /// - Parameters:
  ///   - parts: The parts that the instrument will include
  ///   - volume: The volume for the instrument *(should be between 0 and 1)*. Default is 1. 
  public init(withParts parts: Set<DrumSwinger.DrumPart>, volume: Float = 1) {
    self.sampler = Sampler(for: .drums)
    self.arranger = DrumSwinger(withParts: parts)
    self.sampler.volume = volume
  }
  
  public func createArrangementFor(progression: Sequence.Progression, atTempo tempo: Double) {
    sampler.laySequence(atTempo: tempo) { (track) in
      var beat = MusicTimeStamp(0.0)
      for _ in progression.steps {
        self.arranger.improviseNotes(toTrack: track, onBeat: &beat, //The chord does not matter here.
                                     basedOn: (progression.harmonization, progression.harmonization.chords.randomElement()))
      }
    }
  }
  
  public func addedNote(withMidiValue: Int, atBeat: Double, withDuration: Double) {
    
  }
}

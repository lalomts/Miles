//
//  Bass.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox
import SpriteKit

/// A bass instrument that can be added to a sequence. It creates a walking bassline on top of the sequence chords.
public class Bass: Instrument {
  
  public var sampler: Sampler
  
  public let arranger: Improviser
  
  public var canvas: MilesCanvas?
  
  /// Creates a new bass instrument instance.
  ///
  /// - Parameter volume: The volume for the instrument *(should be between 0 and 1)*. Default is 1.
  public init(volume: Float = 1) {
    arranger = Bassliner()
    self.sampler = Sampler(for: .bass)
    self.sampler.volume = volume
  }
  
  public func createArrangementFor(progression: Sequence.Progression, atTempo tempo: Double) {
    sampler.laySequence(atTempo: tempo) { (track) in
      var beat = MusicTimeStamp(0.0)
      for chordIndex in progression.steps {
        
        arranger.improviseNotes(toTrack: track, onBeat: &beat,
                                basedOn: (progression.harmonization, progression.harmonization.chords[chordIndex]))
      }
    }
  }
  
  
  public func addedNote(withMidiValue: Int, atBeat: Double, withDuration: Double) {
    
  }
}

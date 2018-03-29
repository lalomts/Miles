//
//  Brass.swift
//  Miles
//
//  Created by Lalo Martínez on 3/28/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public class Brass: Instrument {
  
  public enum BrassType: String {
    case sax
    case trumpet
  }
  
  public var sampler: Sampler
  
  public var arranger: Improviser
  
  public var canvas: MilesCanvas?
  
  public let draws: Bool
  
  public init(ofType type: BrassType, inScales scales: Soloer.ScaleRange = (2, 2), withVolume volume: Float = 1, draws: Bool = false ) {
    guard let voice = InstrumentVoice(rawValue: type.rawValue) else { fatalError("No instrument with voice \(type.rawValue)") }
    self.sampler = Sampler(for: voice)
    self.sampler.volume = volume
    self.arranger = Soloer(inScales: scales, canOverlapNotes: false)
    self.draws = draws
    self.arranger.delegate = self
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

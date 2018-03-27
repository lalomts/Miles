//
//  Instrument.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public enum InstrumentVoice: String {
  case piano
  case drums
  case bass
  
  public var midiType: Sampler.MidiBankType {
    switch self {
    case .drums: return Sampler.MidiBankType.Percussion
    default:  return Sampler.MidiBankType.Melody
    }
  }
}

public protocol Instrument {
  
  var sampler: Sampler { get set }
      
  func createArrangementFor(progression: Sequence.Progression, atTempo tempo: Double)
  
  func play()
  
  func stop()

}

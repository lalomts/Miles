//
//  Sampler.swift
//  Miles
//
//  Created by Lalo Martínez on 3/20/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation
import AVFoundation

public class Sampler {
  
  static let melodicBank = UInt8(kAUSampler_DefaultMelodicBankMSB)
  static let defaultBankLSB = UInt8(kAUSampler_DefaultBankLSB)
  static let pianoSoudn = UInt8(0)
  
  var engine: AVAudioEngine
  var sampler: AVAudioUnitSampler
 
  
  public init(fileUrl: URL) {
    
    self.engine = AVAudioEngine()
    self.sampler = AVAudioUnitSampler()
    
    engine.attach(sampler)
    engine.connect(sampler, to: engine.mainMixerNode, format: nil)
    
    
    do {
      
      try sampler.loadSoundBankInstrument(at: fileUrl, program: Sampler.pianoSoudn, bankMSB: Sampler.melodicBank, bankLSB: Sampler.defaultBankLSB)
      
    } catch let error as NSError {
      print("\(error.localizedDescription)")
      return
    }
    
    sampler.sendProgramChange(Sampler.pianoSoudn, bankMSB: Sampler.melodicBank, bankLSB: Sampler.defaultBankLSB, onChannel: 0)
    try! engine.start()
  }
  
  public func startNote(note: Int) {
    sampler.startNote(UInt8(note), withVelocity: 64, onChannel: 0)
  }
  
  public func stopNote(note: Int) {
    sampler.stopNote(UInt8(note), onChannel: 0)
  }
  
}

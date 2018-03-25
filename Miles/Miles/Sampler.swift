//
//  Sampler.swift
//  Miles
//
//  Created by Lalo Martínez on 3/20/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

public class Sampler {
  
  static let melodicBank = UInt8(kAUSampler_DefaultMelodicBankMSB)
  static let defaultBankLSB = UInt8(kAUSampler_DefaultBankLSB)
  static let pianoSoudn = UInt8(0)
  
  let engine: AVAudioEngine
  let pianoSampler: AVAudioUnitSampler
  var sequencer: AVAudioSequencer?
 
  
  public init(fileUrl: URL) {
    self.sequencer = nil
    self.engine = AVAudioEngine()
    self.pianoSampler = AVAudioUnitSampler()
    
    engine.attach(pianoSampler)
    engine.connect(pianoSampler, to: engine.mainMixerNode, format: nil)
    try! engine.start()

    
    do {
      
      try pianoSampler.loadSoundBankInstrument(at: fileUrl, program: Sampler.pianoSoudn, bankMSB: Sampler.melodicBank, bankLSB: Sampler.defaultBankLSB)
//      try pianoSampler.loadInstrument(at: fileUrl)
      
      self.sequencer = AVAudioSequencer(audioEngine: engine)
//      let songURL = Bundle.main.url(forResource: "song", withExtension: "mid")
      
      if let data = Sequencer().data {
        
        try sequencer?.load(from: data, options: [])
        //      try sequencer?.load(from: songURL!, options: AVMusicSequenceLoadOptions.smfChannelsToTracks)
        sequencer?.prepareToPlay()
      }
      
    } catch let error as NSError {
      print("\(error.localizedDescription)")
      return
    }

    pianoSampler.sendProgramChange(Sampler.pianoSoudn, bankMSB: Sampler.melodicBank, bankLSB: Sampler.defaultBankLSB, onChannel: 0)
  }
  
  public func startNote(note: Int) {
    pianoSampler.startNote(UInt8(note), withVelocity: 64, onChannel: 0)
  }
  
  public func stopNote(note: Int) {
    pianoSampler.stopNote(UInt8(note), onChannel: 0)
  }
  
  public func startPlaying() {
    try! sequencer?.start()
  }
  
}

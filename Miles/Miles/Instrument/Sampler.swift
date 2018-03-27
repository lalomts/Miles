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
  
  public enum MidiBankType  {
    case Melody
    case Percussion
    case DefaultBankLSB

    public var value: UInt8 {
      switch self {
      case .Melody: return kAUSampler_DefaultMelodicBankMSB.uint8
      case .Percussion: return kAUSampler_DefaultPercussionBankMSB.uint8
      case .DefaultBankLSB: return kAUSampler_DefaultBankLSB.uint8
      }
    }
    
    public static let defaultProgram: UInt8 = 0
    
  }
  
  let engine: AVAudioEngine
  let sampler: AVAudioUnitSampler
  var sequencer: AVAudioSequencer?
  
  
  public init(for voice: InstrumentVoice) {
    guard let url = Bundle.main.url(forResource: voice.rawValue, withExtension: "sf2")  else { fatalError("Could not load file") }
    
    self.sequencer = nil
    self.engine = AVAudioEngine()
    self.sampler = AVAudioUnitSampler()
    
    do {
      try sampler.loadSoundBankInstrument(at: url, program: MidiBankType.defaultProgram, bankMSB: voice.midiType.value, bankLSB: MidiBankType.DefaultBankLSB.value)
    } catch let error as NSError {
      print("\(error.localizedDescription)")
      return
    }
    
    self.engine.attach(self.sampler)
    self.engine.connect(self.sampler, to: self.engine.mainMixerNode, format: nil)
    try! self.engine.start()
  }
  
  public func attatchTo(engine: AVAudioEngine) {
//    self.engine = engine
//    self.engine!.attach(self.sampler)
//    self.engine!.connect(self.sampler, to: self.engine!.mainMixerNode, format: nil)
  }
  
  public func laySequence(withArrangement arrangement: (MusicTrack) -> Void) {
    
    let newTrack = Track()
    newTrack.populate(withArrangement: arrangement)
    
    do {
      
      self.sequencer = AVAudioSequencer(audioEngine: engine)
      
      if let data = newTrack.data {
        
        try self.sequencer?.load(from: data, options: [])
        
        self.sequencer?.prepareToPlay()
      }
    }
    
    catch let error as NSError {
        print("\(error.localizedDescription)")
        return
    }
  }
  
  public func startPlaying() {
    if let sequencer = sequencer {
      try! sequencer.start()
    }
  }
  
  public func stopPlaying() {
    if let sequencer = sequencer {
      sequencer.stop()
    }
  }
  
//
//  public init(fileUrl: URL) {
//
//    self.sequencer = nil
//    self.engine = AVAudioEngine()
//    self.sampler = AVAudioUnitSampler()
//
//    engine.attach(sampler)
//    engine.connect(sampler, to: engine.mainMixerNode, format: nil)
//    try! engine.start()
//
//
//    do {
//
//      try sampler.loadSoundBankInstrument(at: fileUrl, program: MidiBankType.defaultProgram, bankMSB: MidiBankType.Percussion.value, bankLSB: MidiBankType.DefaultBankLSB.value)
//
//      self.sequencer = AVAudioSequencer(audioEngine: engine)
//
//      if let data = Sequencer().data {
//
//        try sequencer?.load(from: data, options: [])
//        sequencer?.prepareToPlay()
//      }
//
//    } catch let error as NSError {
//      print("\(error.localizedDescription)")
//      return
//    }
//
////    sampler.sendProgramChange(Sampler.pianoSoudn, bankMSB: Sampler.melodicBank, bankLSB: Sampler.defaultBankLSB, onChannel: 0)
//  }
//  
//  public func startNote(note: Int) {
//    sampler.startNote(UInt8(note), withVelocity: 64, onChannel: 0)
//  }
//  
//  public func stopNote(note: Int) {
//    sampler.stopNote(UInt8(note), onChannel: 0)
//  }
//  
 
  
}

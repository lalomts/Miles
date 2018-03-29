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

/// This class encapsulates Apple's AVAudioUnitSampler and AVAudioSequencer in order to load MIDI soundbanks, and create and sequence MIDI events on CoreMIDI tracks and sequences.
///
/// The sampler audio unit can be configured by loading different types of instruments such as an .aupreset file, a DLS or SF2 sound bank. The output is a single stereo bus.

public class Sampler {
  
  /// The volume of the Sampler when connected to the AVAUdioEngine
  public var volume: Float {
    set {
      self.sampler.volume = newValue
    }
    get {
      return self.sampler.volume
    }
  }
  private let engine: AVAudioEngine
  private let sampler: AVAudioUnitSampler
  private var sequencer: AVAudioSequencer?
  
  
  
  /// Creates a new Sampler instance for the specified instrument voice.
  ///
  /// - Parameter voice: The desired voice type.
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
    self.engine.connect(self.sampler, to: self.engine.mainMixerNode, format: sampler.outputFormat(forBus: 0))
    try! self.engine.start()
  }
  
  
  /// Creates a new `MusicSequence`, sets its tempo and returns a `MusicTrack` where the instrument can use its arranging algorithm to create music lines.
  ///
  /// - Parameters:
  ///   - tempo: The tempo that the music sequence will use.
  ///   - arrangement: A codeblock that the instrument uses to create the arrangement.
  public func laySequence(atTempo tempo: Double, withArrangement arrangement: (MusicTrack) -> Void) {
    let newTrack = Track(withTempo: tempo)
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
  
  /// Starts the sequence playback
  public func startPlaying() {
    if let sequencer = sequencer {
      try! sequencer.start()
    }
  }
  
  /// Stops the sequence playback
  public func stopPlaying() {
    if let sequencer = sequencer {
      sequencer.stop()
    }
  }
  
  /// The MIDI bank types a sampler can use for the different sounds. 
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
  
  
}

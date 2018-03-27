//
//  Sequence.swift
//  Miles
//
//  Created by Lalo Martínez on 3/24/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation
import AVFoundation

public class Sequence {
 
  public typealias Progression = ( harmonization: Harmonization, steps: [Int] )
  
  public let audioEngine: AVAudioEngine
  
  public let instruments: [Instrument]
  
  public let harmonization: Harmonization
  
  public var progressionSteps: [Int]
  
  public init(harmonization: Harmonization, withInstruments instruments: [Instrument]) {
    self.harmonization = harmonization
    self.instruments = instruments
    self.progressionSteps = [1,4,2,3,5,4,1,0,3,1,2,4,0,4,3,6,2,3,1,2,3,5,4]
    self.audioEngine = AVAudioEngine()
    
//    for instrument in instruments {
//      instrument.sampler.attatchTo(engine: audioEngine)
//    }
//    try! audioEngine.start()
  }
  
  public func createArrangement() {
    for instrument in instruments {
      instrument.createArrangementFor(progression: (harmonization, progressionSteps))
    }
  }
  
  public func startPlaying() {
    for instrument in instruments {
      instrument.play()
    }
  }
  
  public func stopPlaying() {
    for instrument in instruments {
      instrument.stop()
    }
  }
  
}

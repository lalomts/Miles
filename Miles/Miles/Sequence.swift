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
  
  public let tempo: Double
  
  public var progressionSteps: [Int]
  
  public init(harmonization: Harmonization, tempo: Double = 120, withInstruments instruments: [Instrument]) {
    self.harmonization = harmonization
    self.instruments = instruments
    self.progressionSteps = [1,4,2,3,5,4,1,0,3,1,2,4,0,4,3,6,2,3,1,2,3,5,4]
    self.tempo = tempo
    self.audioEngine = AVAudioEngine()
  }
  
  public func createArrangement() {
    for instrument in instruments {
      instrument.createArrangementFor(progression: (harmonization, progressionSteps), atTempo: tempo)
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

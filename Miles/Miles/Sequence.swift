//
//  Sequence.swift
//  Miles
//
//  Created by Lalo Martínez on 3/24/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AVFoundation

/** A jazz improv sequence that orchestrates the different instruments to create music.

 To use it, follow this steps:
 1. Create one or more instruments like Piano/Bass/Drums
 
        let drums = Drums(withParts: [.snare, .hihats])
 2. Create a `Harmonization` with your desired key and type.
 
        let harmonization = Harmonization(key: .Eflat, type: .harmonicMinor)
 
 3. Create a new `Sequence` with your instruments and your harmonization. You can also provide a tempo *(default is 120 bpm)*
 
        let sequence = Sequence(harmonization: harmonization, tempo: 125, withInstruments: [drums, piano])
 
 3. Tell the sequence the order and the degree of the chords you want to follow. Then create an arrangement following that progresssion.
 
        sequence.steps += [2,5,1,3,6,7,1,2,4,5]
        sequence.createArrangement()

 4. Play the sequence and enjoy a great jazz improv.
 
        sequence.startPlaying()
*/

public class Sequence {
 
  public typealias Progression = ( harmonization: Harmonization, steps: [Int] )
  
  /// The `AVAudioEngine` responsible for the sound playback
  public let audioEngine: AVAudioEngine
  
  /// The `Instruments` that the sequence will use to create the improv.
  public let instruments: [Instrument]
  
  /// The harmonization that the improv session will be based on. *(e.g. E flat harmonic minor)*
  public let harmonization: Harmonization
  
  /// The tempo the improv session will follow
  public let tempo: Double
  
  /// The indexes and order of the chords (inside the harmonization) the improv will follow.
  public var progressionSteps: [Int]
  
  /// Creates a new Sequence instance.
  ///
  /// - Parameters:
  ///   - harmonization: A `Harmonization` instance with the information about the key and scale to derive improv.
  ///   - tempo: The tempo (in beats per minute) the instruments should follow
  ///   - instruments: An array of `Instrument` that will be included in the sequence
  public init(harmonization: Harmonization, tempo: Double = 120, withInstruments instruments: [Instrument]) {
    self.harmonization = harmonization
    self.instruments = instruments
    self.progressionSteps = [1,4,2,3,5,4,1,0,3,1,2,4,0,4,3,6,2,3,1,2,3,5,4]
    self.tempo = tempo
    self.audioEngine = AVAudioEngine()
  }
  
  /// Creates the arrangement using the instrument's indiviual algorithms.
  public func createArrangement() {
    for instrument in instruments {
      instrument.createArrangementFor(progression: (harmonization, progressionSteps), atTempo: tempo)
    }
  }
  
  /// Starts the playback of the improv session.
  public func startPlaying() {
    for instrument in instruments {
      instrument.play()
    }
  }
  
  /// Stops the playback of the session.
  public func stopPlaying() {
    for instrument in instruments {
      instrument.stop()
    }
  }
  
}

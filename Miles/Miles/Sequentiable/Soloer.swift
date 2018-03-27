//
//  Soloer.swift
//  Miles
//
//  Created by Lalo Martínez on 3/26/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

public struct Soloer: Sequentiable {
  
  public typealias HarmonyInfo = (harmonization: Harmonization, chord: Chord)
  
  public let harmonyInfo: HarmonyInfo
  
  public init(harmonyInfo: HarmonyInfo) {
    self.harmonyInfo = harmonyInfo
  }
  
  public func addNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp) {
    
    var internalBeat = MusicTimeStamp(0.0)
    var availableScales = harmonyInfo.chord.quality.improvScales
    availableScales.append( harmonyInfo.harmonization.scale)
    
    let improvScale = availableScales.randomElement()
    print("Will solo in \(harmonyInfo.harmonization.key)\(improvScale) over \(harmonyInfo.chord)")
    while internalBeat <= 4 {
      let durations: [Duration] = [.half(dotted: false), .quarter(dotted: false), .eighth(dotted: false)]
      
      if Int.randomWith(ceil: 5) != 0 { // 1/random probability of having a note
        
        let note = Note.init(tone: improvScale.tones(forKey: harmonyInfo.harmonization.key).randomElement(),
                             octave: Int.randomWith(floor: 3, ceil: 4))
        note.addToTrack(track, onBeat: beat + internalBeat, duration: durations.randomElement(), velocity: Int.randomWith(floor: 40, ceil: 60))
      }
      internalBeat += durations.randomElement().valueDouble
    }
    beat += 4
  }
}

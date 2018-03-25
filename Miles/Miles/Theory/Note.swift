//
//  Note.swift
//  Miles
//
//  Created by Lalo Martínez on 3/22/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox


public struct Note: Sequentable {

  public var tone:Tone
  
  public var octave:Int
  
  public var duration: Duration
  
  public var velocity:Int
  
  public func addToTrack(_ track: MusicTrack, onBeat beat: inout MusicTimeStamp) {
    print("AddtoTrakNote")
  }
  
  public init(tone: Tone, octave: Int, velocity: Int = Int.randomWith(floor: 40, ceil: 70)) {
    self.tone = tone
    self.octave = octave
    self.velocity = velocity
    self.duration = Duration.randomize([.quarter, .sixteenth, .thirtySecond])
  }
  
  public func octaved(_ shift: Int) -> Note {
    return Note(tone: tone, octave: octave + shift, velocity: velocity)
  }
  
}

  


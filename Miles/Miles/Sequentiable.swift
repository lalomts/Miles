//
//  Sequentable.swift
//  Miles
//
//  Created by Lalo Martínez on 3/22/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//
import AudioToolbox

public protocol Sequentiable {
  
  func addToTrack(_ track: MusicTrack, onBeat beat: inout MusicTimeStamp)
}

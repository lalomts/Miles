//
//  Sequentable.swift
//  Miles
//
//  Created by Lalo Martínez on 3/22/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//
import AudioToolbox

public protocol Improviser {
  
  typealias Harmony = (harmonization: Harmonization, chord: Chord)
  
  var delegate: ImproviserDelegate? {get set}
  
  func improviseNotes(toTrack track: MusicTrack, onBeat beat: inout MusicTimeStamp, basedOn harmony: Harmony )
}

public protocol ImproviserDelegate {
  
  func addedNote(withMidiValue: Int, atBeat: Double, withDuration: Double)

}

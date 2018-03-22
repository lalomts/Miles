
//
//  File.swift
//  Miles
//
//  Created by Lalo Martínez on 3/21/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

public class Sequencer {

  public static func createSequence() -> MusicSequence?{
    
    var s: MusicSequence?
    let status = NewMusicSequence(&s)
    
    if status != noErr {
      print("\(#line) bad status \(status) creating sequence")
    }
    
    if let musicSequence = s {
      Sequencer.addTrack(toSequence: musicSequence)
      return musicSequence
    }
    return nil
    
  }
  
  
  public static func addTrack(toSequence sequence: MusicSequence) {
    
    var t: MusicTrack?
    var status = MusicSequenceNewTrack(sequence, &t)
    if status != noErr {
      print("\(#line) bad status \(status) creating sequence")
    }
    
    if let track = t {
      
      // Bank select msb
      var chanmess = MIDIChannelMessage(status: 0xB0, data1: 0, data2: 0, reserved: 0)//MIDI Channel Message for status 176
      status = MusicTrackNewMIDIChannelEvent(track, 0, &chanmess)
      if status != OSStatus(noErr) {
        print("creating bank select event \(status)")
      }
      
      // Bank select lsb
      chanmess = MIDIChannelMessage(status: 0xB0, data1: 32, data2: 0, reserved: 0)// MIDI Channel Message for status 176 / Data byte 1: 32-63 LSB of 0-31
      status = MusicTrackNewMIDIChannelEvent(track, 0, &chanmess)
      if status != OSStatus(noErr) {
        print("creating bank select event \(status)")
      }
      
      // program change. first data byte is the patch, the second data byte is unused for program change messages. Status 192: Command value for Program Change message (https://docs.oracle.com/javase/7/docs/api/javax/sound/midi/ShortMessage.html#PROGRAM_CHANGE)
      chanmess = MIDIChannelMessage(status: 0xC0, data1: 0, data2: 0, reserved: 0)
      status = MusicTrackNewMIDIChannelEvent(track, 0, &chanmess)
      if status != OSStatus(noErr) {
        print("creating program change event \(status)")
      }
      
      // Make some notes to test 🎹
      var beat = MusicTimeStamp(0.0)
      for i: UInt8 in 45...88 {
        var mess = MIDINoteMessage(channel: 0,
                                   note: i,
                                   velocity: 64,
                                   releaseVelocity: 0,
                                   duration:  getRandomDuration())
        status = MusicTrackNewMIDINoteEvent(track, beat, &mess)
        if status != noErr {
          print("creating new midi note event \(status)")
        }
        
        
        var mess2 = MIDINoteMessage(channel: 0,
                                   note: 133 - i,
                                   velocity: 64,
                                   releaseVelocity: 0,
                                   duration:  getRandomDuration())
        var status2 = MusicTrackNewMIDINoteEvent(track, beat, &mess2)
        if status != noErr {
          print("creating new midi note event \(status2)")
        }
        beat += Float64(getRandomDuration())
      }
    }
  }
  
  static func getRandomDuration() -> Float {
    let durations: [Float] = [0.0625, 0.125, 0.25, 0.33, 0.5, 0.75, 1]
    let index = Int(arc4random_uniform(UInt32(durations.count)))
    let element = durations[index]
    return element
  }
  
  
}

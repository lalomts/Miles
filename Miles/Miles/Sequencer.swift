
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
  private var sequence: MusicSequence?
  
  public var data: Data? {
    get {
      guard let sequence = sequence else {return nil}
      var status = OSStatus(noErr)
      var data:Unmanaged<CFData>?
      status = MusicSequenceFileCreateData(sequence,
                                           MusicSequenceFileTypeID.midiType,
                                           MusicSequenceFileFlags.eraseFile,
                                           480, &data)
      if status != noErr {
        print("error turning MusicSequence into NSData")
        return nil
      }
      
      let ns:Data = data!.takeUnretainedValue() as Data
      data?.release()
      return ns
    }
  }
  
  public init() {
    self.sequence = createSequence()
    addTrack()
    
    
  }
  
  /// If possible, creates a new blank empty sequence
  ///
  /// - Returns: The new sequence
  func createSequence() -> MusicSequence? {
    var s: MusicSequence?
    let status = NewMusicSequence(&s)
    
    if status != noErr {
      print("\(#line) bad status \(status) creating sequence")
    }
    
    if let musicSequence = s {
      //      self.addTrack()
      return musicSequence
    }
    return nil
  }
  
  public func addTrack() {
    guard let sequence = sequence else { return }
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
      
      // Testing some notes 🎹
      let harm = Harmonization(key: .A, type: .major)
      var beat = MusicTimeStamp(0.0)
      
      
      for _ in 0...25 {
        let chord = harm.chords.randomElement()
        let comper = ChordComper(chord: chord)
        print(chord)
        comper.addToTrack(track, onBeat: &beat)
      }
      
    }
  }
}

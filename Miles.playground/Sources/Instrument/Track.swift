
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

public struct Track {
  
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
  
  public init(withTempo tempo: Double) {
    self.sequence = createSequence(withTempo: tempo)
  }
  
  /// If possible, creates a new blank empty sequence
  ///
  /// - Returns: The new sequence
  func createSequence(withTempo tempo: Double ) -> MusicSequence? {
    
    var s: MusicSequence?
    let status = NewMusicSequence(&s)
    
    if status != noErr {
      print("\(#line) bad status \(status) creating sequence")
    }
    
    if let musicSequence = s {
      //Set tempo track
      var tempoTrack: MusicTrack?
      MusicSequenceGetTempoTrack(musicSequence, &tempoTrack)
      
      if let tempoTrack = tempoTrack {
        MusicTrackNewExtendedTempoEvent(tempoTrack, 0, tempo)
      }

      return musicSequence
    }
    return nil
  }
  
  private func getTrackLength(musicTrack:MusicTrack) -> MusicTimeStamp {
    
    //The time of the last music event in a music track, plus time required for note fade-outs and so on.
    var trackLength:MusicTimeStamp = 0
    var tracklengthSize:UInt32 = 0
    let status = MusicTrackGetProperty(musicTrack,
                                       UInt32(kSequenceTrackProperty_TrackLength),
                                       &trackLength,
                                       &tracklengthSize)
    if status != OSStatus(noErr) {
      print("Error getting track length \(status)")
      return 0
    }
    return trackLength
  }
  
  public func populate(withArrangement arrange: (MusicTrack) -> Void) {
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
      
      //Populate with a desired arrangement algorithm. 
      arrange(track)
      
    } else {
      fatalError("Could not create track")
    }
  }
}

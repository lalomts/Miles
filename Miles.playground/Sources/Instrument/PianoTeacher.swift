//
//  Teacher.swift
//  Miles
//
//  Created by Lalo Martínez on 3/28/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import AudioToolbox

/// The PianoTeacher is an instrument-like class designed to show how music works by playing different scales and harmonizations in a non-jazz way.
open class PianoTeacher: Drawable {
  
  /// The `MilesCanvas` instance to use when drawing the teacher's notes.
  open var canvas: MilesCanvas?
  
  open var draws: Bool
  
  private let sampler: Sampler
  
  public init(draws: Bool = true) {
    self.sampler = Sampler(for: .piano)
    self.draws = draws
  }
  
  /// Allows the PianoTeacher to show how a scale *feels*. Plays the notes of the scale specified in the key specified.
  ///
  /// - Parameters:
  ///   - scale: The scale to play in.
  ///   - key: The tone used as root by the scale.
  ///   - octaves: The octaves the scale should be played in.
  ///   - tempo: The speed at which the scale should be played.
  ///   - useStaticTime: A Boolean value indicating wether or not all notes should have the same duration.
  open func play(scale: Scale, inKey key: Tone, inOctaves octaves: [Int], withTempo tempo: Double, useStaticTime: Bool) {
    
    canvas?.tempo = tempo
    
    sampler.laySequence(atTempo: tempo) { (track) in
      
      var beat = MusicTimeStamp(0.0)
      
      for octave in octaves {
        
        let durations: [Duration] = [.half(dotted: false), .quarter(dotted: false), .eighth(dotted: false)]
        
        for note in notesForScale(scale: scale, key: key, atOctave: octave) {
          
          let dur: Duration = useStaticTime ? .quarter(dotted: false) : durations.randomElement()
          
          note.addToTrack(track, onBeat: beat, duration: dur)
          
          canvas?.drawCircle(withSizeMiultiplier: 6, boring: useStaticTime, fades: true, delay: beat, lifespan: dur.valueDouble)
          
          beat += dur.valueDouble
        }
      }
    }
    sampler.startPlaying()
  }
  
  /// Allows the PianoTeacher to show how a *harmonization* sounds like. Plays the chords inside the specified harmonization.
  /// All chords' duration is 2 beats of a bar.
  ///
  /// - Parameters:
  ///   - harmonization: The harmonization the `PianoTeacher` instance should play.
  ///   - octave: The octave to play the chords in.
  ///   - tempo: The speed at which the chords should be played
  ///   - arpeggiated: A boolean value indicating wether or not the notes in the chord should be arpeggiated. 
  open func playChordsIn(harmonization: Harmonization, atOctave octave: Int, withTempo tempo: Double, arpeggiated: Bool) {
    
    canvas?.tempo = tempo
    
    sampler.laySequence(atTempo: tempo) { (track) in
      
      var beat = MusicTimeStamp(0.0)
      
      for chord in harmonization.chords {
        
        var internalBeat = MusicTimeStamp(0.0)
        
        for note in chord.notes(atOctave: octave) {
          
          let realBeat = beat + internalBeat
          
          let dur = Duration.half(dotted: false )
          
          note.addToTrack(track, onBeat: realBeat, duration: dur)
          
          canvas?.drawCircle(withSizeMiultiplier: 6, fades: true, delay: realBeat, lifespan: dur.valueDouble)

          internalBeat += arpeggiated ? 0.2 : 0
        }
        
        beat += 2
      }
    }
    sampler.startPlaying()
  }
  
  private func notesForScale(scale: Scale, key: Tone, atOctave octave: Int) -> [Note] {
    
    let mappedNotes = scale.tones(forKey: key).map { (tone: Tone) -> Note in
      
      let correctOctave: Int = tone.index < key.index ? octave + 1 : octave
      
      return Note(tone: tone, octave: correctOctave)
    }
    
    return mappedNotes
  }
  
  
  
}

//
//  Tone.swift
//  Miles
//
//  Created by Lalo Martínez on 3/22/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

public enum Tone: Int, CustomStringConvertible {
  
  case C      = 12
  case Csharp = 13
  case D      = 14
  case Eflat  = 15
  case E      = 16
  case F      = 17
  case Fsharp = 18
  case G      = 19
  case Aflat  = 20
  case A      = 21
  case Bflat  = 22
  case B      = 23
  
  public static var all:[Tone] {
    var all = [Tone]()
    for num in C.rawValue...B.rawValue {
      all.append(Tone(rawValue: num)!)
    }
    return all
  }
  
  public func noteAtInterval(_ interval: Interval) -> Tone{
    let newNote = shiftBy(interval.rawValue)
    return Tone.all[newNote]
  }
  
  public func midiValue(forOctave octave: Int) -> Int {
    return self.rawValue + (12 * octave)
  }
  
  private func shiftBy(_ shift: Int) -> Int{
    let sum = self.index + shift
    let wrap = Tone.all.count - 1
    return sum > wrap ? sum - Tone.all.count : sum
  }
  
  public var index: Int {
    if let index = Tone.all.index(where: {$0 == self}) {
      return index
    }
    print("Could not find index of note")
    return 0
  }
  
  public var description: String {
    switch self {
    case .C:
      return "C"
    case .Csharp:
      return "C♯"
    case .D:
      return "D"
    case .Eflat:
      return "E♭"
    case .E:
      return "E"
    case .F:
      return "F"
    case .Fsharp:
      return "F♯"
    case .G:
      return "G"
    case .Aflat:
      return "A♭"
    case .A:
      return "A"
    case .Bflat:
      return "B♭"
    case .B:
      return "B"
    }
  }
  
  
}

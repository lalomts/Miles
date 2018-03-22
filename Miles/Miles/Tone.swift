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

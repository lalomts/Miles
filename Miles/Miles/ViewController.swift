//
//  ViewController.swift
//  Miles
//
//  Created by Lalo Martínez on 3/19/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import UIKit
import SpriteKit

class TestViewController: UIViewController {
  
  var sequence: Sequence!
  var spriteview: SKView!
  var pianoTeacher: PianoTeacher!

  override func loadView() {
    super.loadView()
    
    view.backgroundColor = .red
    let bass = Bass()
    let piano = Piano(for: .comping, volume: 0.8)
    let pianoSoloer = Piano(for: .soloing, volume: 0.6)
    let drums = Drums(withParts: [.ride, .hihats, .snare, .bass], draws: true)
    
    let harmonization = Harmonization(key: .Bflat, type: .harmonicMinor)
    
    sequence = Sequence(harmonization: harmonization, tempo: 120, withInstruments: [ bass, piano, drums, pianoSoloer])
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(leaved2))
    self.view.addGestureRecognizer(tap)
    
    spriteview = SKView()
    spriteview.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(spriteview)
    
    spriteview.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    spriteview.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    spriteview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    spriteview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    pianoTeacher = PianoTeacher(draws: true)
  }
  
  
  override func viewDidLoad() {
    let scene = MilesCanvas()
    scene.colorPalette = UIColor.purpleRain
    sequence.setDrawingCanvas(scene)
    spriteview.presentScene(scene)
    
    pianoTeacher.canvas = scene
  }
  
  
  @objc func leaved2() {
    sequence.createArrangement()
    sequence.startPlaying()
    
//    pianoTeacher.play(scale: .major,inKey: .A, inOctaves: [2,3], withTempo: 120, useStaticTime: true )
    
//    let harmonization = Harmonization(key: .A, type: .major)
//
//    pianoTeacher.playChordsIn(harmonization: harmonization, atOctave: 3, withTempo: 100, arpeggiated: true)
////
  }

}


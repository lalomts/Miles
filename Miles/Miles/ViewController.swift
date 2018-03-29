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

  override func loadView() {
    super.loadView()
    
    view.backgroundColor = .red
    let bass = Bass()
    let piano = Piano(for: .comping, volume: 0.8)
    let pianoSoloer = Piano(for: .soloing, volume: 0.6)
    let drums = Drums(withParts: [.ride, .hihats, .snare, .bass])
    
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
  }
  
  
  override func viewDidLoad() {
    let scene = MilesCanvas()
    scene.scaleMode = .resizeFill
    sequence.setDrawingCanvas(scene)
    spriteview.presentScene(scene)
  }
  
  
  @objc func leaved2() {
    sequence.createArrangement()
    sequence.startPlaying()
  }

}


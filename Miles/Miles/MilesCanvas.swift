//
//  JazzVisualizer.swift
//  Miles
//
//  Created by Lalo Martínez on 3/27/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import SpriteKit

public class MilesCanvas: SKScene {
  
  public var tempo: Double = 120
  
  private let blend = SKBlendMode.add
    
  public override func didMove(to view: SKView) {
    backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1725490196, blue: 0.2039215686, alpha: 1)
    physicsWorld.gravity = CGVector.zero
  }
  
  private func addPlayer(lifespan: Double) {
    
    let player = SKSpriteNode(imageNamed: "block")
    
    let randomY = random(min: 0, max: size.height)
    let randomX = random(min: size.width * 0.25, max: size.width * 0.75)
    player.position = CGPoint(x: randomX, y: randomY)
    player.texture = nil
    let colors: [UIColor] = [#colorLiteral(red: 0.9647058824, green: 0.737254902, blue: 0.1137254902, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.231372549, blue: 0.0862745098, alpha: 1), #colorLiteral(red: 0.3568627451, green: 0.2392156863, blue: 0.862745098, alpha: 1), #colorLiteral(red: 1, green: 0.3472463191, blue: 0.5793234706, alpha: 1), #colorLiteral(red: 0.3568627451, green: 0.970187717, blue: 0.862745098, alpha: 1), #colorLiteral(red: 0.1803921569, green: 0.7803921569, blue: 0.9450980392, alpha: 1) ]
    
    player.color = colors.randomElement()
    player.colorBlendFactor = 1

    player.blendMode = blendMode
    self.addChild(player)
    run(SKAction.wait(forDuration: lifespan)) {
      player.removeFromParent()
    }
  }
  
  public func queueNote(delay: Double, lifespan: Double) {
        
    run(SKAction.wait(forDuration: delay * 60 / self.tempo)) {
      self.addPlayer(lifespan: lifespan * 60 / self.tempo)
    }
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  
}

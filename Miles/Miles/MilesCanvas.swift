//
//  JazzVisualizer.swift
//  Miles
//
//  Created by Lalo Martínez on 3/27/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import SpriteKit

public class MilesCanvas: SKScene {
  
  public enum DrawableNoteType {
    case block
    case circle(size: CGFloat)
    case string
  }
  
  public var colorPalette: ColorPalette = UIColor.originalMiles
  
  public var tempo: Double = 120
  
  public override func didMove(to view: SKView) {
    backgroundColor = colorPalette.background
    physicsWorld.gravity = CGVector.zero
  }
  
  public func drawNote(ofType type:DrawableNoteType, delay: Double, lifespan: Double) {
    
    run(SKAction.wait(forDuration: convertToTempo(delay))) {
      
      switch type {
        
      case .block: self.addBlock(lifespan: self.convertToTempo(lifespan))
      case .string: self.addString(lifespan: self.convertToTempo(lifespan))
      case .circle(size: let size): self.addCircle(size: size, lifespan: self.convertToTempo(lifespan))        
      }
    }
  }
  
  private func addBlock(lifespan: Double) {
    
    let block = SKSpriteNode(imageNamed: "block\(Int.randomWith(floor: 1, ceil: 3) )")
    
    //Size
    block.size.height *= random(min: 1, max: 2)
    block.size.width *= random(min: 1, max: 1.5)
    
    //Rotation
    let rotation: CGFloat = (CGFloat(Int.randomWith(ceil: 4)) * 90) + random(min: 0, max: 3)
    block.zRotation = rotation * CGFloat.pi / 180
    
    //Position
    let heightAdjust = block.size.height / 2
    let widthAdjust = block.size.width / 2
    
    let randomY = random(min: (size.height * 0.05) + heightAdjust, max: (size.height * 0.9) - heightAdjust)
    let randomX = random(min: (size.width * 0.05) + widthAdjust, max: (size.width * 0.9) - widthAdjust)
    block.position = CGPoint(x: randomX, y: randomY)
        
    //Color
    block.color = colorPalette.colors.randomElement()
    block.colorBlendFactor = 1
    block.blendMode = SKBlendMode.screen
  
    self.addChild(block)
    
    run(SKAction.wait(forDuration: lifespan)) {
      block.removeFromParent()
    }
  }
  
  private func addString(lifespan: Double) {
    
    let string = SKSpriteNode(imageNamed: "string")
    
    //Adjust size
    string.size.height = size.height
    string.size.width = 8
    
    let partialWith = size.width * 0.2
    let widthOffset = (size.width - partialWith) / 2
    
    let xPosition = partialWith / 3 * CGFloat(Int.randomWith(floor: 0, ceil: 3))
    string.position = CGPoint(x: widthOffset + xPosition, y: size.height / 2)
    
    //Color
    string.color = .white
    string.colorBlendFactor = 1
    string.blendMode = SKBlendMode.screen
    
    self.addChild(string)
    
    string.run(SKAction.fadeOut(withDuration: lifespan))
    run(SKAction.wait(forDuration: lifespan)) {
      string.removeFromParent()
    }
  }
  
  private func addCircle(size circleSize: CGFloat, lifespan: Double) {
    
    let circle = SKSpriteNode(imageNamed: "circle")
    
    //Size
    let randomSize = random(min: 20, max: 30) * circleSize
    circle.size = CGSize(width: randomSize, height: randomSize)
    
    //Position
    let heightAdjust = circle.size.height / 2
    let widthAdjust = circle.size.width / 2
    
    let randomY = random(min: (size.height * 0.05) + heightAdjust, max: (size.height * 0.9) - heightAdjust)
    let randomX = random(min: (size.width * 0.05) + widthAdjust, max: (size.width * 0.9) - widthAdjust)
    circle.position = CGPoint(x: randomX, y: randomY)
    
    //Color
    circle.color = colorPalette.colors.randomElement()
    circle.colorBlendFactor = 1
    circle.blendMode = SKBlendMode.screen
    
    self.addChild(circle)
    
    run(SKAction.wait(forDuration: lifespan)) {
      circle.removeFromParent()
    }
  }
  
  public func randomBackground() {
    self.backgroundColor = colorPalette.colors.randomElement()
  }
  
  private func convertToTempo(_ delay: Double) -> Double {
    return delay * 60 / self.tempo
  }
  
  private func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  private func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  
}

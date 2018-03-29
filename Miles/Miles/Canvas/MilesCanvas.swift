//
//  JazzVisualizer.swift
//  Miles
//
//  Created by Lalo Martínez on 3/27/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import SpriteKit

/// MilesCanvas is a sublass of `SKScene` used to render a visual representation of the notes played by Miles. x
public class MilesCanvas: SKScene {
  
  public enum DrawableNoteType {
    case block
    case circle(size: CGFloat)
    case string
  }
  
  /// The color palette used to create the visuals.
  public var colorPalette: ColorPalette = UIColor.originalMiles
  
  public var tempo: Double = 120
  
  private let commonFadeTime: Double = 1.2
  
  //Initial setup
  public override func didMove(to view: SKView) {
    backgroundColor = colorPalette.background
    physicsWorld.gravity = CGVector.zero
    scaleMode = .resizeFill
  }
  
  
  public func drawCircle(withSizeMiultiplier multiplier: CGFloat, boring: Bool = false, fades: Bool = false, delay: Double, lifespan: Double) {
    
    let circle = SKSpriteNode(imageNamed: "circle")
    
    //Size
    let newSize = boring ? 60 : 25 * random(min: 1, max: multiplier)
    circle.size = CGSize(width: newSize, height: newSize)
    
    //Position
    let heightAdjust = circle.size.height / 2
    let widthAdjust = circle.size.width / 2
    
    let randomY = self.random(min: (self.size.height * 0.05) + heightAdjust, max: (self.size.height * 0.9) - heightAdjust)
    let randomX = self.random(min: (self.size.width * 0.05) + widthAdjust, max: (self.size.width * 0.9) - widthAdjust)
    circle.position = CGPoint(x: randomX, y: boring ? size.height / 2 : randomY)
    
    //Color
    circle.color = self.colorPalette.colors.randomElement()
    circle.colorBlendFactor = 1
    circle.blendMode = SKBlendMode.screen
    
    run(SKAction.wait(forDuration: convertToTempo(delay))) {
      self.addChild(circle)
      if fades {
        circle.run(SKAction.fadeOut(withDuration: self.commonFadeTime)) {
          circle.removeFromParent()
        }
      } else {
        self.run(SKAction.wait(forDuration: self.convertToTempo(lifespan))) {
          circle.removeFromParent()
        }
      }
    }
  }
  
  public func drawBlock(withSizeMiultiplier multiplier: CGFloat, boring: Bool = false, fades: Bool = false, delay: Double, lifespan: Double) {
    
    let block = SKSpriteNode(imageNamed: "block\(Int.randomWith(floor: 1, ceil: 3) )")
    
    //Size
    block.size.height *= boring ? 0.5 : random(min: 0.5, max: multiplier)
    block.size.width *= boring ? 0.5 : random(min: 0.5, max: multiplier)
    
    //Rotation
    let rotation: CGFloat = (CGFloat(Int.randomWith(ceil: 4)) * 90) + random(min: 0, max: 3)
    block.zRotation = boring ? 0 : rotation * CGFloat.pi / 180
    
    //Position
    let heightAdjust = block.size.height / 2
    let widthAdjust = block.size.width / 2
    
    let randomY = self.random(min: (self.size.height * 0.05) + heightAdjust, max: (self.size.height * 0.9) - heightAdjust)
    let randomX = self.random(min: (self.size.width * 0.05) + widthAdjust, max: (self.size.width * 0.9) - widthAdjust)
    block.position = CGPoint(x: randomX, y: boring ? size.height / 2 : randomY)
    
    //Color
    block.color = self.colorPalette.colors.randomElement()
    block.colorBlendFactor = 1
    block.blendMode = SKBlendMode.screen
    
    run(SKAction.wait(forDuration: convertToTempo(delay))) {
      self.addChild(block)
      if fades {
        block.run(SKAction.fadeOut(withDuration: self.commonFadeTime)) {
          block.removeFromParent()
        }
      } else {
        self.run(SKAction.wait(forDuration: self.convertToTempo(lifespan))) {
          block.removeFromParent()
        }
      }
    }
  }

  
  public func drawString(delay: Double, lifespan: Double) {
    
    let string = SKSpriteNode(imageNamed: "string")
    
    //Adjust size
    string.size.height = size.height
    string.size.width = 5
    
    let partialWith = size.width * 0.2
    let widthOffset = (size.width - partialWith) / 2
    
    let xPosition = partialWith / 3 * CGFloat(Int.randomWith(floor: 0, ceil: 3))
    string.position = CGPoint(x: widthOffset + xPosition, y: size.height / 2)
    
    //Color
    string.color = .white
    string.colorBlendFactor = 1
    string.blendMode = SKBlendMode.screen
    
    run(SKAction.wait(forDuration: convertToTempo(delay))) {
      self.addChild(string)
      string.run(SKAction.fadeOut(withDuration: self.convertToTempo(lifespan))) {
        string.removeFromParent()
      }
    }
  }
  
  public func drawCymbalCircle(delay: Double, lifespan: Double) {
    
    print("will draw cymbal")
    
    let circle = SKSpriteNode(imageNamed: "circle")
    
    //Size
    let newSize = 40
    circle.size = CGSize(width: newSize, height: newSize)
    
    //Position
    let heightAdjust = circle.size.height / 2
    let widthAdjust = circle.size.width / 2
    
    circle.position = CGPoint(x: (size.width * 0.1 ) + widthAdjust, y:(size.height * 0.1 ) + heightAdjust + random(min: -5, max: 5))
    
    //Color
    circle.color = colorPalette.colors.randomElement()
    circle.colorBlendFactor = 1
    circle.blendMode = SKBlendMode.screen
    
    run(SKAction.wait(forDuration: convertToTempo(delay))) {
      self.addChild(circle)
      circle.run(SKAction.fadeOut(withDuration: self.convertToTempo(lifespan))) {
        circle.removeFromParent()
      }
    }
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

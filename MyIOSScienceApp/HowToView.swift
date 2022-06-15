//
//  HowToView.swift
//  MyIOSScienceApp
//
//  Created by user195957 on 5/18/22.
//

import SpriteKit

class HowToView: SKScene
{
    // Set images in view
    let can = SKSpriteNode(imageNamed: "canImage.png")
    let finish = SKSpriteNode(imageNamed: "finishLine.png")
    let balloon = SKSpriteNode(imageNamed: "balloonImage.png")
    let jumper = SKSpriteNode(imageNamed: "jumper.jpeg")
    
    override func didMove(to view: SKView)
    {
        
    backgroundColor = SKColor.white
        
        // Set the starting positions of the images
    jumper.position = CGPoint(x: size.width/2, y: 415)
    jumper.size = CGSize(width: 80, height: 100)
    addChild(jumper)
    
    balloon.position = CGPoint(x: 300, y: 550)
    balloon.size = CGSize(width: 50, height: 60)
    addChild(balloon)
        
    can.position = CGPoint(x: 100, y: 220)
    can.size = CGSize(width: 50.0, height: 125.0)
    can.zRotation = CGFloat(1.45)
    addChild(can)
        
    }
}

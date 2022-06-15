//
//  GameScene.swift
//  MyIOSScienceApp
//
//  Created by user195957 on 5/13/22.
//

import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate
{
    // Set images.
    let can = SKSpriteNode(imageNamed: "canImage.png")
    let finish = SKSpriteNode(imageNamed: "finishLine.png")
    let balloon = SKSpriteNode(imageNamed: "balloonImage.png")
    let jumper = SKSpriteNode(imageNamed: "jumper.jpeg")
    
    // Set charged text and home button indicator
    let textView = UILabel(frame: CGRect(x: 0, y: 0, width: 250.0, height: 100.0))
    let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60.0, height: 20.0))
    
    // Set categories for the images
    let canCategory:UInt32 = 0x1 << 0
    //let jumperCategory:UInt32 = 0 << 0
    let balloonCategory:UInt32 = 0x1 << 1
    
    // Boolean for charge status
    var balloonCharged: Bool = false
    
    override func didMove(to view: SKView)
    {
        self.physicsWorld.contactDelegate = self
        backgroundColor = SKColor.white
        
        // Physics body code for can
        can.physicsBody?.categoryBitMask = canCategory
        can.physicsBody?.contactTestBitMask = balloonCategory
        can.physicsBody = SKPhysicsBody(rectangleOf: can.frame.size)
        can.physicsBody?.isDynamic = false
        
        // Can starting position
        can.position = CGPoint(x: size.width/2, y: size.height/2)
        can.size = CGSize(width: 50.0, height: 125.0)
        can.zRotation = CGFloat(1.45)
        addChild(can)
        
        // Sequence to ensure can doesnt fall through the floor if Dynamic
        let action = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2),duration: 0)
        let action1 = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2),duration: 0)
        let sequence = SKAction.sequence([action, action1])
        can.run(sequence)
        
        // Jumper starting position
        jumper.position = CGPoint(x: 110, y: 130)
        jumper.size = CGSize(width: 200, height: 250)
        addChild(jumper)
        
        // Finish starting position
        finish.position = CGPoint(x: size.width/2, y: 730)
        finish.size = CGSize(width: 100.0, height: 125.0)
        addChild(finish)
        
        // Balloon starting position
        balloon.position = CGPoint(x: 300, y: 100)
        balloon.size = CGSize(width: 90, height: 100)
        addChild(balloon)
        
        // Textview starting position
        textView.text = "Balloon Charge: NEGATIVE"
        textView.textColor = UIColor.red
        textView.center = CGPoint(x: 150, y: size.height/3.9)
        self.view?.addSubview(textView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        // Check to find jumpers position for charge testing
        //let vectorJ = CGVector(dx: 100, dy: 100)
        //print(vectorJ)
        //print(jumper.position)
        
        // Calls the touch locaiton of the user
        let touchLocation = touch.location(in: self)
        
        // Balloon moves towards touch location
        let vector = CGVector(dx: (touchLocation.x-balloon.position.x), dy: (touchLocation.y-balloon.position.y))
        let balloonMove = SKAction.move(by: vector, duration: 0.1)
        let sequence = SKAction.sequence([balloonMove])
        
        // Find distance between can and finish
        let disCX = (can.position.x - finish.position.x) * (can.position.x - finish.position.x)
        
        let disCY = (can.position.y - finish.position.y) * (can.position.y - finish.position.y)
        
        let distC = sqrt(disCX + disCY)
        print(distC)
        
        // Change text view and indicate home button when can reaches finish line
        if distC <= 1 {
            textView.text = "Well Done!"
            textView.textColor = UIColor.green
            
            homeButton.backgroundColor = UIColor.green
            homeButton.center = CGPoint(x: 350, y: size.height/6)
            homeButton.setTitle("Home", for: .normal)
            self.view?.addSubview(homeButton)
        }
        
        // Physics body for balloon
        balloon.physicsBody = SKPhysicsBody(rectangleOf: balloon.frame.size)
        balloon.physicsBody?.categoryBitMask = balloonCategory
        balloon.physicsBody?.contactTestBitMask = canCategory | balloonCategory
        balloon.physicsBody?.isDynamic = true
        
        // Calculate distance between balloon and jumper
        let disX = (balloon.position.x - jumper.position.x) * (balloon.position.x - jumper.position.x)
        
        let disY = (balloon.position.y - jumper.position.y) * (balloon.position.y - jumper.position.y)
        
        let dist = sqrt(disX + disY)
        //print(dist)
        
        // Change text view when balloon is charged from jumper
        if dist <= 5 {
            balloonCharged = true
            print(balloonCharged)
            textView.text = "Balloon Charge: POSITIVE"
            textView.textColor = UIColor.blue
        }
        
        // Move the balloon when touch location changes
        balloon.run(sequence)
    }
    
    // Stop balloon from falling through the floor when not moving
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        balloon.physicsBody?.isDynamic = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("Collision")
      
        // Move the can upwards when colliding with the balloon
        if contact.bodyA.node == can && balloonCharged == true || contact.bodyB.node == balloon && balloonCharged == true {
            let vector = CGVector(dx: 0.0, dy: 2)
            let vector2 = CGVector(dx: 0.0, dy: 0.0)
            let canMove = SKAction.move(by: vector, duration: 1)
            let canMoveDone = SKAction.move(by: vector2, duration: 0)
            let sequence = SKAction.sequence([canMove, canMoveDone])
            can.run(sequence)
        }
    }
    // Stop the can from moving when collision ends
    func didEnd(_ contact: SKPhysicsContact) {
        if contact.bodyA.node != can || contact.bodyB.node != balloon {
            let vector = CGVector(dx: 0.0, dy: 0.0)
            let canStop = SKAction.move(by: vector, duration: 0)
            let sequence = SKAction.sequence([canStop])
            can.run(sequence)
        }
    }
}
 

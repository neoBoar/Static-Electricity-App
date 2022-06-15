//
//  GameViewController.swift
//  MyIOSScienceApp
//
//  Created by user195957 on 5/13/22.
//

import UIKit
import SpriteKit

class GameViewController : UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }
}

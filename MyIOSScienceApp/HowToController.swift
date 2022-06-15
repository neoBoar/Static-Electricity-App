//
//  HowToController.swift
//  MyIOSScienceApp
//
//  Created by user195957 on 5/18/22.
//

import UIKit
import SpriteKit

class HowToController : UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = HowToView()
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }
}

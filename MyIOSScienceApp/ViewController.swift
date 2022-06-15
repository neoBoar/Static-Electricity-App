//
//  ViewController.swift
//  MyIOSScienceApp
//
//  Created by user195957 on 5/13/22.
//

import UIKit
import SpriteKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let scene = ViewScene()
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }


}


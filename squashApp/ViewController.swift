//
//  ViewController.swift
//  squashApp
//
//  Created by Leo on 10/9/18.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let juego = JuegoViewController();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func comenzar(_ sender: UIButton) {
        juego.comenzar();
    }
    
}


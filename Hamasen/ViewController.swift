//
//  ViewController.swift
//  Hamasen
//
//  Created by Eric Lin on 2018/12/9.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rotaryDial = RotaryDial()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(rotaryDial)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rotaryDial.frame = CGRect(x: 0, y: 0, width: min(view.bounds.width, view.bounds.height), height: min(view.bounds.width, view.bounds.width))
        rotaryDial.center = view.center
        rotaryDial.commonInit()
    }
    
    
    
    
}


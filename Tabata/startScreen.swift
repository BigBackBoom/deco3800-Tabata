//
//  startScreen.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/04/23.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import UIKit

class startScreen: UIViewController {
    
    @IBOutlet var startButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(exeSetting.exeTime); //test
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
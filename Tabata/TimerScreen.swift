//
//  ViewController.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import UIKit 
import AVFoundation

class TimerScreen: UIViewController {
    
    @IBOutlet var circleProgressBar: CircleProgressView!
    @IBOutlet var startButton: UIButton!
    
    var timerLabel: UILabel!
    var countingTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating timer label programatically
        timerLabel = UILabel()
        timerLabel.frame = CGRectMake(0, 0, 200, 21)
        timerLabel.center = CGPointMake(circleProgressBar.frame.width/2, circleProgressBar.frame.height/2)
        timerLabel.textAlignment = NSTextAlignment.Center
        
        //initializing countdown timer
        countingTimer = Timer(counter: exeSetting.exeTime,  cycle: exeSetting.cycle, restTime: exeSetting.restTime, circleProgressBar: circleProgressBar, timerLabel: timerLabel)
        
        //inserting timer label value, which is depending on user input(from timePicker)
        timerLabel.text =  countingTimer.timerNotation(timeInSec: exeSetting.exeTime)
        circleProgressBar.addSubview(timerLabel)
        countingTimer.startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


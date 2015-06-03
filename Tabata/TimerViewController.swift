//
//  ViewController.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import UIKit 
import AVFoundation

class TimerViewController: UIViewController {
    
    @IBOutlet weak var circleProgressBar: CircleProgressView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var currentCycleLabel: UILabel!
    @IBOutlet weak var totalCyclesLabel: UILabel!
    @IBOutlet weak var backdropWork: UIImageView!
    @IBOutlet weak var backdropRest: UIImageView!
    
    var timerLabel: UILabel!
    var countingTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating timer label programatically
        timerLabel = UILabel()
        timerLabel.frame = CGRectMake(0, 0, 200, 200)
        timerLabel.center = CGPointMake(circleProgressBar.frame.width/2, circleProgressBar.frame.height/2)
        timerLabel.textAlignment = NSTextAlignment.Center
        timerLabel.font = UIFont(name: timerLabel.font.fontName, size: 80)
        timerLabel.textColor = UIColor(red: 224/255, green: 79/255, blue: 14/255, alpha: 1.0)
        
        //initializing countdown timer
        countingTimer = Timer(counter: exeSetting.exeTime,  cycle: exeSetting.cycle, restTime: exeSetting.restTime, circleProgressBar: circleProgressBar, timerLabel: timerLabel, currentCycleLabel: currentCycleLabel, backdropWork:backdropWork, backdropRest: backdropRest)
        
        totalCyclesLabel.text = String(exeSetting.cycle)
        
        //inserting timer label value, which is depending on user input(from timePicker)
        //timerLabel.text =  countingTimer.timerNotation(timeInSec: exeSetting.exeTime)
        circleProgressBar.addSubview(timerLabel)
        countingTimer.startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


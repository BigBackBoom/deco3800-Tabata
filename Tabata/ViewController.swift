//
//  ViewController.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import UIKit 

class ViewController: UIViewController {
    
    @IBOutlet var circleProgressBar: CircleProgressView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var timerLabel: UILabel!;
    var countingTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.countDownDuration = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func starBtnPressed(){
        timerLabel = UILabel();
        timerLabel.frame = CGRectMake(0, 0, 200, 21)
        timerLabel.center = CGPointMake(circleProgressBar.frame.width/2, circleProgressBar.frame.height/2)
        timerLabel.textAlignment = NSTextAlignment.Center
        countingTimer = Timer(counter: timePicker.countDownDuration, circleProgressBar: circleProgressBar, timerLabel: timerLabel, timerPicker: timePicker)
        timerLabel.text = countingTimer.timerNotation(timeInSec: Int(timePicker.countDownDuration))
        circleProgressBar.addSubview(timerLabel)
        timePicker.removeFromSuperview()
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: countingTimer, selector: "timerDecrement", userInfo: nil, repeats: false)
    }
    
    @IBAction func pauseButton(sender: AnyObject) { }
    @IBAction func clearButton(sender: AnyObject) { }


}


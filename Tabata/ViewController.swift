//
//  ViewController.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import UIKit 
import AVFoundation
import Parse

class ViewController: UIViewController {
    
    @IBOutlet var circleProgressBar: CircleProgressView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var player : AVAudioPlayer!
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
    
    /**
        This function triggers countdown timer.
        Codes will delete timerpicker interface and replace with countdown label.
        Circularbar will be initialized and start filling the bar.
        At last, it calls countdown function to start actual counting down.
    */
    @IBAction func startBtnPressed(){
        //creating timer label programatically
        timerLabel = UILabel();
        timerLabel.frame = CGRectMake(0, 0, 200, 21)
        timerLabel.center = CGPointMake(circleProgressBar.frame.width/2, circleProgressBar.frame.height/2)
        timerLabel.textAlignment = NSTextAlignment.Center
        /****************************************************************************************************/
        
        //initializing countdown timer
        countingTimer = Timer(counter: timePicker.countDownDuration, circleProgressBar: circleProgressBar, timerLabel: timerLabel, timerPicker: timePicker)
        
        //inserting timer label value, which is depending on user input(from timePicker)
        timerLabel.text = countingTimer.timerNotation(timeInSec: Int(timePicker.countDownDuration))
        circleProgressBar.addSubview(timerLabel)
        //audio Test
        let fileString = NSBundle.mainBundle().pathForResource("timlim", ofType: "mp3")
        let url = NSURL(fileURLWithPath: fileString!)
        player = AVAudioPlayer(contentsOfURL: url, error: nil)
        player.prepareToPlay()
        player.play()
        /****************************************************************************************/
        
        //remove timePicker from screen
        timePicker.removeFromSuperview()
        
        //start timer
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: countingTimer, selector: "timerDecrement", userInfo: nil, repeats: false)
    }
    
    @IBAction func pauseButton(sender: AnyObject) { }
    @IBAction func clearButton(sender: AnyObject) { }


}


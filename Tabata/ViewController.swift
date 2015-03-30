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
    @IBOutlet var timePicker: UIDatePicker!
    
    weak var timer: NSTimer!
    var timerLabel: UILabel!;
    var initCount: Double!
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.countDownDuration = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func starBtnPressed(){
        initCount = Double(timePicker.countDownDuration)
        counter = initCount
        timerLabel = UILabel();
        timerLabel.frame = CGRectMake(0, 0, 200, 21)
        timerLabel.center = CGPointMake(circleProgressBar.frame.width/2, circleProgressBar.frame.height/2)
        println(timerLabel.center)
        timerLabel.textAlignment = NSTextAlignment.Center
        timerLabel.text = timerNotation(timeInSec: Int(counter))
        circleProgressBar.addSubview(timerLabel)
        timePicker.removeFromSuperview()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerDecrement"), userInfo: nil, repeats: false)
    }
    
    func timerNotation(timeInSec time: Int) -> String{
        var hour:Int = time/3600
        var min:Int = (time-3600*hour)/60
        var sec:Int =  time - 3600*hour - min*60
        var strhour:String = String(hour)
        var strmin:String = String(min)
        var strsec:String = String(sec)
        if (hour < 10) {
            strhour = "0" + strhour
        }
        
        if (min < 10 || min == 0){
            strmin = "0" + strmin
        }
        
        if (sec < 10){
            strsec = "0" + strsec
        }
        
        return strhour + ":" + strmin + ":" + strsec
    }
    
    func timerDecrement (){
        counter -= 0.01;
        circleProgressBar.progress = 1 - (Double(counter)/Double(initCount))
        timerLabel.text = timerNotation(timeInSec: Int(counter))
        
        if(counter != 0){
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("timerDecrement"), userInfo: nil, repeats: false)
        } else {
            timerLabel.removeFromSuperview()
            timePicker.frame = CGRectMake(0, 0, 227, 162)
            timePicker.center = CGPointMake(circleProgressBar.frame.width/2, circleProgressBar.frame.height/2)
            println(timePicker.center)
            circleProgressBar.addSubview(timePicker)
        }
    }
    
    @IBAction func pauseButton(sender: AnyObject) { }
    @IBAction func clearButton(sender: AnyObject) { }


}


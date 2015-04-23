//
//  Timer.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/04/10.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import UIKit

/**
Count Down Timer Initialized

:param: counter A double, which value will be used for countdown length
:param: circleProgressBar A progress bar class to be updated on controller view.
:param: timerLabel A label interface to be updated on controller view.
:param: timerPicker timePicker to add at the end of the timer on controller view.

*/

public class Timer {
    var circleProgressBar: CircleProgressView!
    var timerLabel: UILabel!
    var timerPicker: UIDatePicker!
    var counter: Double!
    var initCount: Double!
    
    init(counter: Double, circleProgressBar: CircleProgressView, timerLabel: UILabel, timerPicker: UIDatePicker){
        self.counter = counter
        self.initCount = counter
        self.circleProgressBar = circleProgressBar
        self.timerLabel = timerLabel
        self.timerPicker = timerPicker
    }
    
    /**
        private function to turn seconds into proper time notation; hh:mm:ss
        
        :param: timeInSec An interger value to be transform.
    
        :returns: A String of timer notation
    */
    func timerNotation(timeInSec time: Int) -> String{
        //transforming seconds to hh:mm:ss format
        var hour:Int = time/3600
        var min:Int = (time-3600*hour)/60
        var sec:Int =  time - 3600*hour - min*60
        var strhour:String = String(hour)
        var strmin:String = String(min)
        var strsec:String = String(sec)
        
        //if a value is less than 10, add zero to maintain two digits notation; hh:mm:ss, instead of h:mm:ss, h:m:s or etc
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
    
    /**
    A function decrement timer by 0.01, but only updates timer label every 1 second.
    */
    @objc func timerDecrement(){
        
        //minus counter from 0.01
        counter = counter - 0.01;
        //update circular progress bar
        circleProgressBar.progress = 1 - (Double(counter)/Double(initCount))
        //update timer label but only in with integer
        timerLabel.text = timerNotation(timeInSec: Int(counter))
        
        //if a counter still have remaining time, coundown go on
        if(counter > 0){
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
        //if timer is end, recreate time picker.
        } else {
            timerLabel.removeFromSuperview()
            timerPicker.frame = CGRectMake(300, 300, 227, 162)
            timerPicker.center = circleProgressBar.center
            
            circleProgressBar.addSubview(timerPicker)
        }
    }
    
}
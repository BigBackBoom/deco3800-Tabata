//
//  Timer.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/04/10.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import UIKit

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
    
    @objc func timerDecrement(){
        
        println(counter)
        counter = counter - 0.01;
        circleProgressBar.progress = 1 - (Double(counter)/Double(initCount))
        println(circleProgressBar.progress)
        timerLabel.text = timerNotation(timeInSec: Int(counter))
        
        if(counter > 0){
            //println(circleProgressBar.progress)
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
        } else {
            println("afdafda")
            println(timerPicker.center)
            timerLabel.removeFromSuperview()
            timerPicker.frame = CGRectMake(300, 300, 227, 162)
            timerPicker.center = circleProgressBar.center
            println(timerPicker.center)
            
            circleProgressBar.addSubview(timerPicker)
        }
    }
    
}
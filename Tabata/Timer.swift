//
//  Timer.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/04/10.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation

public class Timer {
    var counter: Int!
    
    init(time: ){

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
        counter--;
        timerLabel.text = timerNotation(timeInSec: counter)
        
        if(counter != 0){
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerDecrement"), userInfo: nil, repeats: false)
        } else {
            timerLabel.removeFromSuperview()
            timePicker.frame = CGRectMake(0, 0, 227, 162)
            timePicker.center = CGPointMake(circleProgressView.frame.width/2, circleProgressView.frame.height/2)
            println(timePicker.center)
            circleProgressView.addSubview(timePicker)
        }
    }
    
}
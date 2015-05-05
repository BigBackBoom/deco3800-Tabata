//
//  Timer.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/04/10.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

/**
Count Down Timer Initialized

:param: counter A double, which value will be used for countdown length
:param: circleProgressBar A progress bar class to be updated on controller view.
:param: timerLabel A label interface to be updated on controller view.
:param: timerPicker timePicker to add at the end of the timer on controller view.

*/

public class Timer {
    
    private struct ExcerciseInfo {
        var counter: Double!
        var exeTime: Double!
        var cycle: Int!
        var restTime:Double!
        var mode:Int;
    }
    
    var circleProgressBar: CircleProgressView!
    var timerLabel: UILabel!
    private var exerciseInfo: ExcerciseInfo!
    var player : AVAudioPlayer!
    
    init(counter: Double, cycle: Int, restTime: Double, circleProgressBar: CircleProgressView, timerLabel: UILabel){
        self.exerciseInfo = ExcerciseInfo(counter: counter, exeTime: counter, cycle: cycle, restTime: restTime, mode: 0)
        self.circleProgressBar = circleProgressBar
        self.timerLabel = timerLabel
    }
    
    /**
        function to turn seconds into proper time notation; hh:mm:ss
        
        :param: timeInSec An interger value to be transform.
    
        :returns: A String of timer notation
    */
    public func timerNotation(timeInSec time: Double) -> String{
        //transforming seconds to hh:mm:ss format
        var hour:Int = Int(time/3600)
        var min:Int =  (Int(time) - 3600*hour)/60
        var sec:Int =  Int(time) - 3600*hour - min*60
        var mil:Int = Int((time - Double(hour) - Double(min) - Double(sec))*100)
        var strhour:String = String(hour)
        var strmin:String = String(min)
        var strsec:String = String(sec)
        var strmil:String = String(mil)
        
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
        
        if (mil < 10){
            strmil = "0" + strmil
        }
        
        return strmin + ":" + strsec + ":" + strmil
    }
    
    /**
    A function decrement timer by 0.01, but only updates timer label every 1 second.
    */
    @objc func timerDecrement(){
        
        //minus counter from 0.01
        exerciseInfo.counter = exerciseInfo.counter - 0.01;
        //update circular progress bar
        if (exerciseInfo.mode == 0) {
            circleProgressBar.progress = 1 - (Double(exerciseInfo.counter)/Double(exerciseInfo.exeTime))
        } else {
            circleProgressBar.progress = 1 - (Double(exerciseInfo.counter)/Double(exerciseInfo.restTime))
        }
        
        //update timer label but only in with integer
        timerLabel.text = timerNotation(timeInSec: exerciseInfo.counter)
        
        if(exerciseInfo.cycle > 0){
            //if a counter still have remaining time, coundown go on
            if(exerciseInfo.counter > 0){
                NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
                //if timer is end, recreate time picker.
            } else {
                if (exerciseInfo.mode == 0){
                    exerciseInfo.counter = exerciseInfo.restTime
                    exerciseInfo.cycle  = exerciseInfo.cycle - 1;
                    exerciseInfo.mode = 1
                } else {
                    exerciseInfo.counter = exerciseInfo.exeTime
                    exerciseInfo.mode = 0
                }
                
                NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
                
            }
            
        } else{
            timerLabel.text = "Finished!"
        }
        
    }
    
    /**
    This function triggers countdown timer.
    Codes will delete timerpicker interface and replace with countdown label.
    Circularbar will be initialized and start filling the bar.
    At last, it calls countdown function to start actual counting down.
    */
    
    func startTimer(){
        
        //audio Test
        let fileString = NSBundle.mainBundle().pathForResource("timlim", ofType: "mp3")
        let url = NSURL(fileURLWithPath: fileString!)
        player = AVAudioPlayer(contentsOfURL: url, error: nil)
        player.prepareToPlay()
        player.play()
        /****************************************************************************************/
        
        
        //start timer
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
    }
    
}
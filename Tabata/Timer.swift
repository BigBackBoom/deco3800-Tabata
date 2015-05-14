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
        var exeTime: Double!
        var cycle: Int!
        var restTime:Double!
        var mode:Int
    }
    
    var circleProgressBar: CircleProgressView!
    var timerLabel: UILabel!
    var player : AVAudioPlayer!
    var startTime = NSTimeInterval()
    
    private var exerciseInfo: ExcerciseInfo!
    
    public init(counter: Double, cycle: Int, restTime: Double, circleProgressBar: CircleProgressView, timerLabel: UILabel?){
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
        self.exerciseInfo = ExcerciseInfo(exeTime: counter, cycle: cycle, restTime: restTime, mode: 0)
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
        let min = Int(time / 60)
        let sec = Int(time%60)
        let mil = Int(round((time - Double(min * 60) - Double(sec))*100))
        
        //if a value is less than 10, add zero to maintain two digits notation; hh:mm:ss, instead of h:mm:ss, h:m:s or etc
        var strmin =  min < 10 || min == 0 ? "0" + String(min) : String(min)
        var strsec =  sec < 10 ? "0" + String(sec) : String(sec)
        var strmil = mil < 10 ? "0" + String(mil) : String(mil)
        
        return strmin + ":" + strsec + ":" + strmil
    }
    
    /**
        the timer is called and find remaining time from current time and a timer started time.
    */
    @objc func timerDecrement(){
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        
        //calculate amount of time left
        var counter = exerciseInfo.mode == 0 ? exerciseInfo.exeTime - elapsedTime : exerciseInfo.restTime - elapsedTime
        //update circular progress bar
        if (exerciseInfo.mode == 0) {
            circleProgressBar.progress = 1 - (Double(counter)/Double(exerciseInfo.exeTime))
        } else {
            circleProgressBar.progress = 1 - (Double(counter)/Double(exerciseInfo.restTime))
        }
        
        //update timer label but only in with integer
        timerLabel.text = timerNotation(timeInSec: counter)
        
        if(exerciseInfo.cycle > 0){
            //if a counter still have remaining time, coundown go on
            if(counter > 0){
                NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
            } else {
                //check mode of timer and decide whether going into exercise or rest
                if (exerciseInfo.mode == 0){
                    exerciseInfo.cycle  = exerciseInfo.cycle - 1
                    exerciseInfo.mode = 1
                } else {
                    exerciseInfo.mode = 0
                }
                self.startTime = NSDate.timeIntervalSinceReferenceDate()
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
    
    public func startTimer(){
        
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
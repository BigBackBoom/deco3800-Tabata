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
:param: setLabel A label interface to be updated on controller view.

*/

public class Timer {
    
    private enum exerciseMode:Int {
        case Exercise = 0
        case Rest
        case Finished
    }
    
    private struct ExcerciseInfo {
        var exeTime: Double!
        var cycle: Int!
        var restTime:Double!
        var mode:exerciseMode
    }
    
    weak var circleProgressBar: CircleProgressView!
    weak var timerLabel: UILabel!
    weak var currentCycleLabel: UILabel!
    weak var backdropWork: UIImageView!
    weak var backdropRest: UIImageView!
    var player : AVAudioPlayer!
    var startTime = NSTimeInterval()
    var soundUrls:[NSURL] = []
    
    private var exerciseInfo: ExcerciseInfo!
    
    public init(counter: Double, cycle: Int, restTime: Double, circleProgressBar: CircleProgressView, timerLabel: UILabel?, currentCycleLabel: UILabel?, backdropWork: UIImageView?, backdropRest: UIImageView?){
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
        self.exerciseInfo = ExcerciseInfo(exeTime: counter, cycle: cycle, restTime: restTime, mode: .Exercise)
        self.circleProgressBar = circleProgressBar
        self.timerLabel = timerLabel
        self.currentCycleLabel = currentCycleLabel
        self.backdropWork = backdropWork
        self.backdropRest = backdropRest
        
        soundSetUp()
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
        var counter = exerciseInfo.mode == .Exercise ? exerciseInfo.exeTime - elapsedTime : exerciseInfo.restTime - elapsedTime
        
        //update circular progress bar
        if (exerciseInfo.mode == .Exercise) {
            circleProgressBar.progress = 1 - (Double(counter)/Double(exerciseInfo.exeTime))
        } else {
            circleProgressBar.progress = 1 - (Double(counter)/Double(exerciseInfo.restTime))
        }
        
        // convert into minutes for timer display
        let minutes = Int(round(counter))
        let strMinutes = minutes > 9 ? String(stringInterpolationSegment: minutes):"0" + String(stringInterpolationSegment: minutes)
        
        //update timer label but only in with integer
        timerLabel.text = "0:\(strMinutes)" // first zero is a fake
        currentCycleLabel.text = String(exerciseInfo.cycle)
        
        func colorize (redIn: Int, greenIn:Int, blueIn:Int, alpha: Double = 1.0) -> UIColor {
            
            let red = Double(redIn) / 255.0
            
            let green = Double(greenIn) / 255.0
            
            let blue = Double(blueIn) / 255.0
            
            var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
            
            return color
            
        }
        
        if(exerciseInfo.cycle > 0){
            //if a counter still have remaining time, coundown go on
            if(counter > 0){
                NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
            } else {
                //check mode of timer and decide whether going into exercise or rest
                if (exerciseInfo.mode == .Exercise){
                    exerciseInfo.cycle  = exerciseInfo.cycle - 1
                    exerciseInfo.mode = exerciseInfo.cycle > 0 ? .Rest : .Finished
                    backdropWork.hidden = true
                    backdropRest.hidden = false
                    timerLabel.textColor = colorize(0,170,68, alpha:1.0)
                    currentCycleLabel.textColor = colorize(0,170,68, alpha:1.0)
                    circleProgressBar.trackFillColor = colorize(0,170,68, alpha:1.0)
                    circleProgressBar.trackBackgroundColor = colorize(0,170,68, alpha:1.0).colorWithAlphaComponent(0.5)
                    player = AVAudioPlayer(contentsOfURL: soundUrls[exerciseInfo.mode.rawValue], error: nil)
                    player.prepareToPlay()
                    player.play()
                } else {
                    exerciseInfo.mode = .Exercise
                    backdropRest.hidden = true
                    backdropWork.hidden = false
                    timerLabel.textColor = colorize(224,79,14, alpha:1.0)
                    currentCycleLabel.textColor = colorize(224,79,14, alpha:1.0)
                    circleProgressBar.trackFillColor = colorize(224,79,14, alpha:1.0)
                    circleProgressBar.trackBackgroundColor = colorize(224,79,14, alpha:1.0).colorWithAlphaComponent(0.5)
                    player = AVAudioPlayer(contentsOfURL: soundUrls[exerciseInfo.mode.rawValue], error: nil)
                    player.prepareToPlay()
                    player.play()
                }
                self.startTime = NSDate.timeIntervalSinceReferenceDate()
                NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
                
            }
            
        } else{
            timerLabel.font = UIFont(name: timerLabel.font.fontName, size: 40)
            timerLabel.text = "Finished!"
        }
        
    }
    
    private func soundSetUp(){
        let filename = ["exeStart", "rest", "finished"]
        
        for name in filename{
            var fileString = NSBundle.mainBundle().pathForResource(name, ofType: "m4a")
            var url = NSURL(fileURLWithPath: fileString!)
            soundUrls.append(url!)
        }
    }
    
    /**
        This function triggers countdown timer.
        Codes will delete timerpicker interface and replace with countdown label.
        Circularbar will be initialized and start filling the bar.
        At last, it calls countdown function to start actual counting down.
    */
    
    public func startTimer(){
        player = AVAudioPlayer(contentsOfURL: soundUrls[0], error: nil)
        player.prepareToPlay()
        player.play()
        
        //start timer
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerDecrement", userInfo: nil, repeats: false)
    }
    
}
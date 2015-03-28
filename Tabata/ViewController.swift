//
//  ViewController.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import UIKit 

class ViewController: UIViewController {
    
    @IBOutlet var circleProgressView: CircleProgressView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var timePicker: UIDatePicker!
    
    weak var timer: NSTimer!
    var timerLabel = UILabel();
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func starBtnPressed(){
        println(timePicker.countDownDuration)
        timerLabel.frame = CGRectMake(50, 150, 200, 21)
        timerLabel.backgroundColor = UIColor.orangeColor()
        timerLabel.textColor = UIColor.blackColor()
        timerLabel.textAlignment = NSTextAlignment.Center
        timerLabel.text = "test label"
        self.view.addSubview(timerLabel)
        //timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerIncrement"), userInfo: nil, repeats: false)
    }
    
    func timerIncrement (){
        counter++;
        timerLabel.text = String(counter)
        
        if(counter != 0){
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerIncrement"), userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func pauseButton(sender: AnyObject) { }
    @IBAction func clearButton(sender: AnyObject) { }


}


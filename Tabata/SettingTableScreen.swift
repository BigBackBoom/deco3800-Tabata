//
//  SettingTableScreen.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/05/13.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import UIKit

class SettingTableScreen: UITableViewController{
    
    @IBOutlet weak var exeVal: UITextField!
    @IBOutlet weak var restVal: UITextField!
    @IBOutlet weak var cycleVal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exeVal.text = String(stringInterpolationSegment: exeSetting.exeTime)
        restVal.text = String(stringInterpolationSegment: exeSetting.restTime)
        cycleVal.text = String(stringInterpolationSegment: exeSetting.cycle)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveData() {
        exeSetting.exeTime = (exeVal.text as NSString).doubleValue
        exeSetting.restTime = (restVal.text as NSString).doubleValue
        exeSetting.cycle = (cycleVal.text as NSString).integerValue
        //presentViewController(startScreen, animated: true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: {})
    }

}


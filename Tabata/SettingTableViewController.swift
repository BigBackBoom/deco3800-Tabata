//
//  SettingTableScreen.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/05/13.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import UIKit

class SettingTableViewController: UITableViewController{
    
    @IBOutlet weak var txtExeTime: UITextField!
    @IBOutlet weak var txtRestTime: UITextField!
    @IBOutlet weak var txtCycle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        txtExeTime.text = String(stringInterpolationSegment: exeSetting.exeTime)
        txtRestTime.text = String(stringInterpolationSegment: exeSetting.restTime)
        txtCycle.text = String(stringInterpolationSegment: exeSetting.cycle)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveData() {
        exeSetting.exeTime = (txtExeTime.text as NSString).doubleValue
        exeSetting.restTime = (txtRestTime.text as NSString).doubleValue
        exeSetting.cycle = (txtCycle.text as NSString).integerValue
        //presentViewController(startScreen, animated: true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: {})
    }

}


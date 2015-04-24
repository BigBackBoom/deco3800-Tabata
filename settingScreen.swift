//
//  settingScreen.swift
//  Tabata
//
//  Created by Kodai Kikuchi on 2015/04/24.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import Foundation
import UIKit

class settingScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var exeVal: UILabel!
    var restVal: UILabel!
    var soundVal: UILabel!
    var cycleVal: UILabel!
    
    @IBOutlet var tableView: UITableView!
    var items: [String] = ["Excercise", "Rest", "Sound", "help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var exeVal = UILabel()
        var restVal = UILabel()
        var soundVal = UILabel()
        var cycleVal = UILabel()
        
        exeVal.text = String(stringInterpolationSegment: exeSetting.exeTime)
        exeVal.frame = CGRectMake(0, 0, 100, 50)
        restVal.text =  String(stringInterpolationSegment: exeSetting.restTime)
        restVal.frame = CGRectMake(0, 0, 100, 50)
        soundVal.text =  String(stringInterpolationSegment: exeSetting.sound)
        soundVal.frame = CGRectMake(0, 0, 100, 50)
        cycleVal.text =  String(exeSetting.cycle)
        cycleVal.frame = CGRectMake(0, 0, 100, 50)
        cell.textLabel?.text = self.items[indexPath.row]
        
        switch indexPath.row{
            case 0:
                cell.addSubview(exeVal)
            case 1:
                cell.addSubview(restVal)
            case 2:
                cell.addSubview(soundVal)
            case 3:
                cell.addSubview(cycleVal)
            default:
                println("default");
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}
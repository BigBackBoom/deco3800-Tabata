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
    
    var exeVal: UITextField!
    var restVal: UITextField!
    var soundVal: UITextField!
    var cycleVal: UITextField!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBarSetting: UINavigationItem!
    var items: [String] = ["Excercise", "Rest", "Sound", "help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let customBackButton: UIBarButtonItem = UIBarButtonItem(title: "< Back", style: .Plain, target: self, action: Selector("savedata"))
        navBarSetting.leftBarButtonItem = customBackButton

    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        createTable(cell, row:indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    @objc func savedata(){
        exeSetting.exeTime = (exeVal.text as NSString).doubleValue
        exeSetting.restTime = (exeVal.text as NSString).doubleValue
        exeSetting.sound = (exeVal.text as NSString).doubleValue
        exeSetting.cycle = (exeVal.text as NSString).integerValue
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let startScreen = storyboard.instantiateViewControllerWithIdentifier("startScreen") as! UIViewController
        //presentViewController(startScreen, animated: true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: {})

    }
    
    private func createTable (cell:UITableViewCell, row: Int){
        
        switch row{
        case 0:
            exeVal = UITextField()
            exeVal.keyboardType = UIKeyboardType.NumberPad
            exeVal.text = String(stringInterpolationSegment: exeSetting.exeTime)
            exeVal.frame = CGRectMake((cell.frame.size.width - 30), 0, 100, 50)
            cell.addSubview(exeVal)
        case 1:
            restVal = UITextField()
            restVal.text =  String(stringInterpolationSegment: exeSetting.restTime)
            restVal.frame = CGRectMake((cell.frame.size.width - 30), 0, 100, 50)
            cell.addSubview(restVal)
        case 2:
            soundVal = UITextField()
            soundVal.keyboardType = UIKeyboardType.NumberPad
            soundVal.text =  String(stringInterpolationSegment: exeSetting.sound)
            soundVal.frame = CGRectMake((cell.frame.size.width - 30), 0, 100, 50)
            cell.addSubview(soundVal)
        case 3:
            cycleVal = UITextField()
            cycleVal.keyboardType = UIKeyboardType.NumberPad
            cycleVal.text =  String(exeSetting.cycle)
            cycleVal.frame = CGRectMake((cell.frame.size.width - 30), 0, 100, 50)
            cell.addSubview(cycleVal)
        default:
            println("default");//need error checking
        }
    }
    
}
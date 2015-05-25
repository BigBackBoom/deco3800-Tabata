//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//
/*

import UIKit
import XCTest
import Tabata

class TimerTests: XCTestCase {
    
    var timerLabel = UILabel()
    var countingTimer: Timer!
    var circleProgressBar = CircleProgressView()
    
    override func setUp() {
        super.setUp()
        
        //initializing countdown timer
        countingTimer = Timer(counter: 40.0,  cycle: 4, restTime: 10, circleProgressBar: circleProgressBar, timerLabel: timerLabel)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimerNotation() {
        // This is an example of a functional test case.
        XCTAssertEqual(countingTimer.timerNotation(timeInSec: 40.0), "00:40:00", "Two time notation strings are not matching")
        
        XCTAssertEqual(countingTimer.timerNotation(timeInSec: 60.0), "01:00:00", "Two time notation strings are not matching")
        
        XCTAssertEqual(countingTimer.timerNotation(timeInSec: 120.10), "02:00:10", "Two time notation strings are not matching")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
*/
//
//  DatabaseCommsTests.swift
//  DatabaseCommsTests
//
//  Created by Kodai Kikuchi on 2015/03/19.
//  Copyright (c) 2015年 deco3800. All rights reserved.
//

import UIKit
import XCTest
import Tabata

class DatabaseCommsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testLogin() {
        var username = "Hoge"
        var password = "deco3800"
        
        //Testing that login:: function return false
        XCTAssert(!login(username, password), "The reult need to be false")
        
        username = "mike"
        password = "1234"
        //Testing login:: returns true
        XCTAssert(login(username, password), "The reult need to be true")
    }
    
    /**func testSignUp() {
        var username = "Hoge"
        var password = "deco3800"
        var email = "test@test.com"
        
        //signup and test login
        //signUp(username, password, email)
        
        var user = PFUser()
        user.username = name
        user.password = password
        user.email = email
        user.signUp()
        //XCTAssert(login(username, password), "The result need to be true")
        var query = PFQuery(className:"User")
        query.whereKey("username", equalTo: "Hoge")
        
        println(query.getFirstObject())
    }**/
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

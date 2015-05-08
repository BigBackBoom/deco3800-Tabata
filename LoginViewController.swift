//
//  LoginVC.swift
//  Test
//
//  Created by Chan Weng Hou on 11/25/14.
//  Copyright (c) 2014 Chan Weng Hou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view. hahaha dumb ass
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinTapped(sender: UIButton){
        var username:NSString = txtUsername.text
        var password:NSString = txtPassword.text
        
        println("hello")
        println(credentials.usernameC)
        if ( username.isEqualToString(credentials.usernameC) && password.isEqualToString(credentials.passwordC)) {
            
            
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: nil)
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Login Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

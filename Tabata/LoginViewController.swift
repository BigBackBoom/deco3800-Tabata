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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(sender: UIButton){
        var username = txtUsername.text
        var password = txtPassword.text
        
        if (!login(username, password)) {
            var alertController = UIAlertController(title: "Login Failed", message: "You entered wrong username or password", preferredStyle: .Alert)
            let alertConfirm = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
                (action:UIAlertAction!) -> Void in
            }
            alertController.addAction(alertConfirm)
            presentViewController(alertController, animated: true, completion: nil)
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

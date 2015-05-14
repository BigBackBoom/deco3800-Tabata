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
    
    @IBAction func signinTapped(sender: UIButton){
        var username:NSString = txtUsername.text
        var password:NSString = txtPassword.text
        
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
    
    func logIn(name:String, pass:String) -> Bool{
        var user: PFUser?
        user = PFUser.logInWithUsername(name, password: pass)
        if user != nil{
            return true;
        }else{
            return false
        }
    }
    
    func signUp(name:String, pass:String, email:String) -> Bool{
        var user = PFUser()
        user.username = name
        user.password = pass
        user.email = email
        
        return user.signUp()
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

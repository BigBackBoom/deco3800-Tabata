//

//  SignUpViewController.swift

//  Tabata

//

//  Created by Weng hou Chan on 14/05/2015.

//  Copyright (c) 2015 deco3800. All rights reserved.

//



import UIKit

class SignUpViewController: UIViewController {
    
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
    
    
    
    @IBAction func signupTapped(sender: AnyObject) {
        var alertView:UIAlertView = UIAlertView()
        //alertView.title = "Order Cancelled"
        
        credentials.usernameC = (txtUsername.text as NSString) as String
        credentials.passwordC = (txtPassword.text as NSString) as String
        
        alertView.message = "Account Created!"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        }
    
    
    
    @IBAction func gotoLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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


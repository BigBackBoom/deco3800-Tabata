//

//  SignUpViewController.swift

//  Tabata

//

//  Created by Weng hou Chan & Kodai Kikuchi on 14/05/2015.

//  Copyright (c) 2015 deco3800. All rights reserved.

//



import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view. hahaha dumb ass
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func signupTapped(sender: AnyObject) {
        var alertController:UIAlertController
        var result:Bool!
        var handler:(UIAlertAction!)->Void;
        
        var username = txtUsername.text
        var password = txtPassword.text
        var email = txtEmail.text
        
        result = signUp(username, password, email)
        
        if(result == true){
            alertController = UIAlertController(title: "Account is created", message: "You have successfully created an account.", preferredStyle: .Alert)
            handler = {(action:UIAlertAction!) in self.dismissViewControllerAnimated(true, completion: nil)}
            
        } else {
            alertController = UIAlertController(title: "Account is not created", message: "Please try again", preferredStyle: .Alert)
            handler = {(action:UIAlertAction!) in }
        }
        
        let alertConfirm = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: handler)
        alertController.addAction(alertConfirm)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func gotoLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
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


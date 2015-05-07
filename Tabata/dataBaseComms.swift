//
//  dataBaseComms.swift
//  Tabata
//
//  Created by Harrison Barton & Kodai Kikuchi on 2015/05/07.
//  Copyright (c) 2015 deco3800. All rights reserved.
//

func logIn(name:String, pass:String){
    var result:Bool!
    
    PFUser.logInWithUsernameInBackground(name, password: pass, block: {
        (user: PFUser?, error: NSError?) -> Void in
        if user != nil {
            // Do stuff after successful login.
            //result = true
            println("login successful")

        } else {
            // The login failed. Check error to see why.
            //result = false
            println("login failed")
            
        }
    })
}

func signUp(name:String, pass:String, email:String){
    
    var user = PFUser()
    user.username = name
    user.password = pass
    user.email = email
    
    user.signUpInBackgroundWithBlock {
        (succeeded: Bool, error: NSError?) -> Void in
        if let error = error {
            let errorString = error.userInfo?["error"] as? NSString
            println(errorString)
        } else {
            // Hooray! Let them use the app now.
            println("Account has been successfully created");
        }
    }
}

func createExercise(name:String, length:Int, rest:Int, sets:Int)
{
    var currentUser = PFUser.currentUser()
    var exercise = PFObject(className:"Exercise")
    exercise["User"] = currentUser
    exercise["Exercise_name"] = name
    exercise["Exercise_length"] = length
    exercise["Exercise_rest_length"] = rest
    exercise["Exercise_set"] = sets
    exercise.pinInBackground()
}

//Retrieve exercises - this one just returns the first one found

func retrieveExercise() -> PFObject?
{
    var currentUser:PFUser!  = PFUser.currentUser()
    let userId = currentUser.objectId
    var result:PFObject?
    
    var query = PFQuery(className:"Exercise")
    query.fromLocalDatastore()
    query.whereKey("User", equalTo: userId!)
    
    query.getFirstObjectInBackgroundWithBlock {
        (object: PFObject?, error: NSError?) -> Void in
        if error != nil || object == nil {
             result = nil
        } else {
            // The find succeeded.
            result = object
        }
    }
    return result
}

//Edit excercise

func editExercise(currentExer:PFObject, name:String, length:Int, rest:Int, sets:Int)
{
    currentExer["Exercise_name"] = name
    currentExer["Exercise_length"] = length
    currentExer["Exercise_rest_length"] = rest
    currentExer["Exercise_set"] = sets
    currentExer.pinInBackground()
}

//Log exercise

func logExercise(currentExercise:PFObject) {
    
    var currentUser = PFUser.currentUser()
    var exercise_log = PFObject(className:"Exercise_Log")
    exercise_log["User"] = currentUser
    exercise_log["Exercise"] = currentExercise
    exercise_log.saveInBackgroundWithBlock {
        (success: Bool, error: NSError?) -> Void in
        if (success) {
            
        } else {
            // There was a problem, check error.description
            
        }
    }
}

func retrieveLog(currentExercise:PFObject) -> PFObject?
{
    var result:PFObject?
    var currentUser:PFUser! = PFUser.currentUser()
    let userId = currentUser.objectId
    let exerId = currentExercise.objectId
    
    var query = PFQuery(className:"Exercise_Log")
    query.whereKey("User", equalTo: userId!)
    query.whereKey("Exercise", equalTo: exerId!)
    query.getFirstObjectInBackgroundWithBlock {
        (object: PFObject?, error: NSError?) -> Void in
        if error != nil || object == nil {
            result = nil
        } else {
            // The find succeeded.
            result =  object
        }
    }
    return result
}
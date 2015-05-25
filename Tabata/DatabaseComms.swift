//
//  dataBaseComms.swift
//  Tabata
//
//  Created by Harrison Barton & Kodai Kikuchi on 2015/05/07.
//  Copyright (c) 2015 deco3800. All rights reserved.
//


/**
Login function using two parameter

:param: username A user name of the account that the client would like to log in with
:param: password A password to verify username

:returns: return PFUser if sucessful. Return nil if username or password is wrong

*/

public func login(name:String, pass:String) -> Bool{
    
    return PFUser.logInWithUsername(name, password: pass) != nil ? true : false
}

/**
Asynchronous signup

:param: username of the account
:param: password A password to verify this username
:param: email A email for contact

*/
public func signUp(name:String, pass:String, email:String) -> Bool{
    
    var user = PFUser()
    user.username = name
    user.password = pass
    user.email = email
    
    return user.signUp()
    
    /*user.signUpInBackgroundWithBlock {
        (succeeded: Bool, error: NSError?) -> Void in
        if let error = error {
            let errorString = error.userInfo?["error"] as? NSString
            println(errorString)
        } else {
            // Hooray! Let them use the app now.
            println("Account has been successfully created")
        }
    }*/
}

/**
Create new exercise record on Database

:param: name A name of the exercise
:param: length Duration of exercise
:param: rest Rest duration between exercise
:param: sets Number of sets user did

:returns: return true if successful

*/

public func createExercise(name:String, length:Int, rest:Int, sets:Int) -> Bool{
    var currentUser = PFUser.currentUser()
    var exercise = PFObject(className:"Exercise")
    exercise["User"] = currentUser
    exercise["Exercise_name"] = name
    exercise["Exercise_length"] = length
    exercise["Exercise_rest_length"] = rest
    exercise["Exercise_set"] = sets
    return exercise.pin()
}

/**
Retrieve latest exercise.

:returns: PFObject of contains data or nil

*/
public func retrieveExercise() -> PFObject? {
    
    var currentUser:PFUser!  = PFUser.currentUser()
    let userId = currentUser.objectId
    var query = PFQuery(className:"Exercise")
    query.fromLocalDatastore()
    query.whereKey("User", equalTo: userId!)
    
    return query.getFirstObject()
}

/**
Edit excercise

:param: PFObject Current Exercise
:param: name A name of the exercise
:param: length Duration of exercise
:param: rest Rest duration between exercise
:param: sets Number of sets user did


*/
public func editExercise(currentExer:PFObject, name:String, length:Int, rest:Int, sets:Int) {
    currentExer["Exercise_name"] = name
    currentExer["Exercise_length"] = length
    currentExer["Exercise_rest_length"] = rest
    currentExer["Exercise_set"] = sets
    currentExer.pinInBackground()
}

/**
Log exercise

:param: currentExercise A currently working exercise to log

**/
public func logExercise(currentExercise:PFObject) {
    
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

/**
Retrieve log exercise

:param: currentExercise A currently working exercise to log

:returns: PFObject

**/

public func retrieveLog(currentExercise:PFObject) -> PFObject? {
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
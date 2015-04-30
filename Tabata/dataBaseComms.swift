//
//  AppDelegate.swift
//  Tabata
//
//  Created by Harrison Burton on 2015/04/30.
//  Copyright (c) 2015 deco3800. All rights reserved.
//

import Parse

// Create new user

func signUp(name:String, pass:String, email:String) {
  var user = PFUser()
  user.username = name
  user.password = pass
  user.email = email
 
  user.signUpInBackgroundWithBlock {
    (succeeded: Bool?, error: NSError?) -> Void in
    if let error = error {
      let errorString = error.userInfo?["error"] as? NSString
      // Show the errorString somewhere and let the user try again.
    } else {
      // Hooray! Let them use the app now.
    }
  }
}

//Log in - must be done before database use!

funct logIn(name:String, pass:String){
  PFUser.logInWithUsernameInBackground(name, password:pass) {
    (user: PFUser?, error: NSError?) -> Void in
    if user != nil {
      // Do stuff after successful login.
    } else {
      // The login failed. Check error to see why.
    }
  }
}

//Creating a new exercise

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

func retrieveExercise() -> PFObject
{
  var currentUser = PFUser.currentUser()
  let userId = currentUser.objectId

  var query = PFQuery(className:"Exercise")
  query.fromLocalDatastore()
  query.whereKey("User", equalTo: userId)
  query.getFirstObjectInBackgroundWithBlock {
    (object: PFObject?, error: NSError?) -> Void in
    if error != nil || object == nil {
      return null
    } else {
      // The find succeeded.
      return object
    }
  }
}

//Edit excercise

func createExercise(currentExer:PFObject, name:String, length:Int, rest:Int, sets:Int)
{
  currentExer["Exercise_name"] = name
  currentExer["Exercise_length"] = length
  currentExer["Exercise_rest_length"] = rest
  exercise["Exercise_set"] = sets
  exercise.pinInBackground()
}

//Log exercise

func logExercise(currentExercise:PFObject)
{
  var currentUser = PFUser.currentUser()
  var exercise_log = PFObject(className:"Exercise_Log")
  exercise["User"] = currentUser
  exercise["Exercise"] = currentExercise
  exercise.saveInBackgroundWithBlock {
    (success: Bool, error: NSError?) -> Void in
    if (success) {
      // The object has been saved.
    } else {
      // There was a problem, check error.description
    }
  }
}

//View log - again, just returning the first result

func retrieveLog(currentExercise:PFObject) -> PFObject
{
  var currentUser = PFUser.currentUser()
  let userId = currentUser.objectId
  let exerId = currentExercise.objectId

  var query = PFQuery(className:"Exercise_Log")
  query.whereKey("User", equalTo: userId)
  query.whereKey("Exercise", equalTo: exerId)
  query.getFirstObjectInBackgroundWithBlock {
    (object: PFObject?, error: NSError?) -> Void in
    if error != nil || object == nil {
      return null
    } else {
      // The find succeeded.
      return object
    }
  }
}

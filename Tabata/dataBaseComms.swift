//
//  AppDelegate.swift
//  Tabata
//
//  Created by Harrison Burton on 2015/04/30.
//  Copyright (c) 2015 deco3800. All rights reserved.
//

import Parse

var currentUser = ??????

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

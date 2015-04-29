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

var exercise = PFObject(className:"Exercise")
exercise["User"] = currentUser
exercise["Exercise_name"] = "Whatever that would be"
exercise["Exercise_length"] = 180
exercise["Exercise_rest_length"] = 30
gameScore.pinInBackground()

//Retrieve exercises

let userId = currentUser.objectId

var query = PFQuery(className:"Exercise")
query.fromLocalDatastore()
query.whereKey("User", equalTo: userId)
query.getObjectInBackgroundWithId("xWMyZEGZ") {
  (exercise: PFObject?, error: NSError?) -> Void in
  if error == nil && exercise!= nil {
    println(exercise)
  } else {
    println(error)
  }
}

//Log exercise

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

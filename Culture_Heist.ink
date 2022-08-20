-> set_vars
//keep variables up here
==set_vars==
VAR timer = 30
VAR next_end = ->introduction
VAR Car_Arrived = 0
-> introduction

== timer_text(-> return_to_story) ==
-(postscript)
"At this point we would only have {timer} minutes to complete the heist."
+ [Stop checking watch]
    -> return_to_story
    
+ [Wait]
    -> wait(-> postscript)


== wait(-> return_to) ==
"You are gonna wait there for a minute."
-> return_to

== advance_time ==
~timer = timer - 1
{timer == 0: ->next_end}

== introduction ==
"So, here is the plan."
The leader tapped on the map of the museum.
"We are going to steal the [insert here]."

/*-(postscript)
 -> timer_text(-> done)
-(done)#*/
 "Are you ready to go over the plan?"
 * [Yes] "Good." 
 -> Driver_Start
 * [No] "Well too bad. We only have so much time."
-> Driver_Start

==Travel==

*"Go to the car dealership"
-> Driver_End
//locations go below here
==Secret_Base==
The leader looked around the dark damp walls of the Secret base.
"You already know this place well obviously. Too bad we will have to be leaving it soon"
The leader sighed wistfully.

+[Leave the Base]"You are going to head out that door over there." 
->Travel

->END

TODO: add location nodes -Marlene and Patrick


//the below nodes handle the meta conversation where the leader describes
//the plan or objections are raised to it. The format is Start, objects, End
== Driver_Start ==
~timer = 30
~next_end = ->Driver_End
"Okay so Kai you are going to be the getaway driver."
The leader pointed at the map again.
"That means you won't be directly going into the museum. Instead you will organise disguises and get a car to the museum so the others can get out.'

// use + not * so when the story loops choices are still available
+"Get the car."
    <-advance_time
    ~Car_Arrived = timer
    -> Secret_Base
+"Go straight to the museum."
    ->Driver_End
    
//this can be used to let the playr wait or check turns remaining
+[Check watch]
    -(postscript)
        -> timer_text(-> done)
    -(done)
    -> Driver_Start //this needs to be different
==Car_not_present==
Jules spoke up. "How am I supposed to escape if there is no escape vehicle?" "You are right lets go over this again"
-> Driver_Start

TODO: add objections to the driver part of the plan -David

== Driver_End ==
" Okay so that is the plan for Kai. Any objections?"
{Car_Arrived == 0: ->Car_not_present}
"Good"
-> Recon_Start

== Recon_Start ==
"Okay so Rico will be a sort of Recon agent there to help Jules steal the artifact. It will be your job to make it as easy as possible for Jules to get in and out."
-> Recon_End

TODO: add objections to the Recon part of the plan -David

==Recon_End==
"Any objections with Rico's part of the plan?"
"Ok, moving on"
-> Thief_Start

==Thief_Start==
"And finally we get to our resident procurement specialist. Jules, your job is to use the resources and oppurtunities that Rico and Kai set up to get into the museum's storage vault and steal the artifact."
-> Thief_End

TODO: add objections to thief part of plan -David
==Thief_End==
"Does that plan sound good to everyone."
"Then that is it"
-> Closing

== Closing ==
"Okay now that everyone knows their parts its time to get ready to leave. We only have until the artifact is transfered to pull this off. Lets go" 
The leader paused for one second.
"Good luck"
//check to demonstrate times being held
"Kai will get the car {Car_Arrived} minute{Car_Arrived > 1:s} before the heist is complete."
-> END

//testing
-> set_vars
//keep variables up here
===set_vars===
VAR timer = 30

VAR Car_Arrived = 0
-> introduction

=== timer_text(-> return_to) ===
"At this point we would only have {timer} minutes to complete the heist."
-> return_to

=== introduction ===
"So, here is the plan."
The leader tapped on the map of the museum.
"We are going to steal the [insert here]."

//peepee poopoo

-(postscript)
 -> timer_text(-> done)
-(done)
 "Are you ready to go over the plan?"
 * [Yes] "Good." 
 -> Driver_Start
 * [No] "Well too bad. We only have so much time."
-> Driver_Start

//locations go below here

//locations go above here

=== Driver_Start ===
~timer = 30 
"Okay so Kai you are going to be the getaway driver."
The leader pointed at the map again.
"That means you won't be directly going into the museum. Instead you will organise disguises and get a car to the museum so the others can get out.'

// use + not * so when the story loops choices are still available
+"Get the car."
    ~timer = timer-1
    ~ Car_Arrived = timer
    ->Driver_End
+"Go straight to the museum."
    -> Driver_End

=== Driver_End ===
" Okay so that is the plan for Kai. Any objections?"
{Car_Arrived == 0: ->Car_not_present}
"Good"
-> Recon_Start

=== Recon_Start ===
"Okay so Rico will be a sort of Recon agent there to help Jules steal the artifact. It will be your job to make it as easy as possible for Jules to get in and out."
-> Recon_End

===Recon_End===
"Any objections with Rico's part of the plan?"
"Ok, moving on"
-> Thief_Start

===Thief_Start===
"And finally we get to our resident procurement specialist. Jules, your job is to use the resources and oppurtunities that Rico and Kai set up to get into the museum's storage vault and steal the artifact."
-> Thief_End

===Thief_End===
"Does that plan sound good to everyone."
"Then that is it"
-> Closing

=== Closing ===
"Okay now that everyone knows their parts its time to get ready to leave. We only have until the artifact is transfered to pull this off. Lets go" 
The leader paused for one second.
"Good luck"
//check to demonstrate times being held
"Kai will get the car {Car_Arrived} minute{Car_Arrived > 1:s} before the heist is complete."
-> END

//objections down here perhaps these should be threads
===Car_not_present===
Jules spoke up. "How am I supposed to escape if there is no escape vehicle?" "You are right lets go over this again"
-> Driver_Start

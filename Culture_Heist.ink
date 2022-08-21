-> set_vars
//keep variables up here
==set_vars==
VAR timer = 0
VAR timer_default = 5
LIST Inventory = (Placeholder)
~Inventory = ()
VAR next_end = ->introduction
//preparation action variables.
VAR Car_Arrived = 0
VAR Costumes_Dropped_Off = 0
VAR Staff_Door_Unlocked = 0
VAR Distraction_Created = 0
VAR Guard_Knocked_Out = 0
VAR Cameras_Off = 0
VAR Security_Off = 0

-> introduction

== timer_text(-> return_to_story) ==
-(postscript)
"At this point we would only have {timer} minutes to complete the heist."
+ [Stop checking watch]
    -> return_to_story
    
+ [Wait]
    -> wait(-> postscript)

TODO: there is currently a bug where waiting to the end of a loop with the watch causes the watch options to be available at the start of the next loop
== wait(-> return_to) ==
"You are gonna wait there for a minute."
<-advance_time
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
~timer = timer_default
~next_end = ->Driver_End
"Okay so Kai you are going to be the getaway driver."
The leader pointed at the map again.
"That means you won't be directly going into the museum. Instead you will organise disguises and get a car to the museum so the others can get out.'

// use + not * so when the story loops choices are still available
+"Get the car."
    <-advance_time
    ~Car_Arrived = timer
    -> Driver_Start
+"Go straight to the museum."
    ->Driver_End
    
//this can be used to let the playr wait or check turns remaining
+[Check watch]
    -(postscript)
        -> timer_text(-> done)
    -(done)
    -> Driver_Start //this needs to be different
    
==Outside==
"Once you're outside you'll be able to see the two giant doors leading to the museum's front hall. The museum also received a large grant recently, so you'll see the cheesy bushes shaped like famous statues out there as well.

+[Enter the meuseum]
    ->Museum_Entryway

==Museum_Entryway==
"When you sneak in the museum's entryway, there will be a guard running patrol, an empty front desk ahead of you, and a water bottle re-fill station to your left."

+[Go to the Main Hall]
    ->Main_Hall

+[Exit the museum]
    ->Outside

==Main_Hall==
"This is where all of the less important historical artifacts are kept for public viewing."
 
+[Enter Side Hall 1]
    ->Side_Hall_1

+[Enter Side Hall 2]
    ->Side_Hall_2
    
+[Go to Entryway]
    ->Museum_Entryway

==Side_Hall_1==
"This is where"

+[Enter Guard Hall] "That's where you come in and use those muscles to lift the giant metal gate blocking the entrance to the Guard Hall. Unfortunately it will shut behind you once you crawl under, but you can deal with that again if you need to." //Only visable to the Recon
    ->Guard_Hall

+[Go to the Main Hall]
    ->Main_Hall

==Side_Hall_2==
"jodjfoedmfoe"

+[Enter vents to Mailroom] "Thanks to your small frame you should be able to crawl through the air vents and find your way to the Mailroom. //Only visable to the Thief
    ->Mailroom
    
+[Go to the Main Hall]
    ->Main_Hall
    
==Mailroom==
"hisnisn"
    
+[Enter Guard Hall]
    ->Guard_Hall

+[Enter Vents to Side Hall 2] //Only Visable to the Thief
    ->Side_Hall_2

==Guard_Hall==
"bdjsbujb"

*[Knock out guard]

+[Go to the Mailroom]
    ->Mailroom
    
+[Go to Security Room] //Only if you've gotten the disguises
    ->Security_Room
    
+[Go to Vault Hall] //Only visable if you've gotten the key card
    ->Vault_Hall

+[Go to Side Hall 1] //Only visable to the Recon
    ->Side_Hall_1
    
==Security_Room==
"dhudsnsinis"


==Vault_Hall==
"hdudhfije"





//Driver objections
==Car_not_present==
Jules spoke up. "How am I supposed to escape if there is no escape vehicle?" 
"You are right lets go over this again"
-> Driver_Start

==Costumes_not_dropped==
Rico spoke up "Jules and I are going to need some kind of disguise to get around the staff hallways."
He paused for a second and said "I mean the plan is to not get caught, right."
The leader pondered the possibility of getting caught on purpose for a second and then responded. 
"It certainly isn't. We must have missed something. Let's go over this again.
-> Driver_Start

==Door_not_open==
Rico spoke up "We are going to need to have the loading bay staff door unlocked if we are going to escape through that door."
He pointed at the map.
"It says here that the door is locked from the loading bay side."
The leader studied the map.
"Right you are Rico. Let' go over this again to make sure we have the right plan down."
->Driver_Start

== Driver_End ==
" Okay so that is the plan for Kai. Any objections?"
{Car_Arrived == 0: ->Car_not_present}
{Costumes_Dropped_Off == 0: ->Costumes_not_dropped}
{Staff_Door_Unlocked == 0: ->Door_not_open}
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

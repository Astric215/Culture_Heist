-> set_vars
//keep variables up here
==set_vars==
VAR timer = 0
VAR timer_default = 5
VAR has_costumes = false
VAR has_car = false
VAR has_keycard = false

VAR next_end = ->introduction
LIST trait = (Nothing), Charismatic, Strong, Sneaky
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

== function next_character ==
~timer = timer_default
~trait++
== introduction ==
"So, here is the plan."
The leader tapped on the map of the museum.
"We are going to steal the [insert here]."
 ~ next_character()

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
"bsnennusw"

+[Go to the Mailroom]
    ->Mailroom
    
+[Go to Security Room]
    //If costumes obtained ->Costumes_Obtained
    //If costumes not obtained ->Costumes_not_Obtained
    
+[Go to Vault Hall] //Only visable if you've gotten the key card
    ->Vault_Hall

+[Go to Side Hall 1] //Only visable to the Recon
    ->Side_Hall_1
    


==Vault_Hall==
"hdudhfije"


==Costumes_Obtained==
"When you enter the Security Room you'll see computer screens lining the walls. To your left will be the button you'll have to press to turn off and wipe the security cameras. Thankfully you've already picked up the security guard uniforms so being spot won't be a problem."

+[Exit the Security Room]
    ->Guard_Hall

==Costumes_not_Obtained==
Kai cuts the leader off "Wait wait wait. I didn't go through all that trouble grabbing that guard uniform for you to waltz into the Security Room looking like a convict." 
"They're right," Rico says, "If I'm gonna be going into the Security Room I'm gonna need to pick up The uniform Kai dropped off for me in the mailroom."
"All right then, so Rico, you don't go into the Security Room."
    ->Guard_Hall
//the below nodes handle the meta conversation where the leader describes
//the plan or objections are raised to it. The format is Start, objects, End

== Driver_Start ==
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

//Driver objections
==Car_not_present==
Jules started to speak in a groan and she held her face in her palm. "How am I supposed to escape if there is no escape vehicle?"
Kai timidly looked around the table.
The leader took a deep breath and then turned towards "Kai I know this is your first heist but you need to get your task complete."
Kai nodded quickly. "Yes. I understand. I'm sorry."
The leader gave a slight nod. "Its okay but just to be sure we are all on the same page lets go over this again."
-> Driver_Start

==Costumes_not_dropped==
Rico spoke up "Jules and I are going to need some kind of disguise to get around the staff hallways."
He paused for a second and said "I mean the plan is to not get caught, right."
Kai gave a slight chuckle. "I'm pretty sure the leader would tell us if that was the plan."
The entire team turned to look toward the leader.
The leader pondered the possibility of getting caught on purpose for a second and then responded. 
"It certainly isn't the plan to get caught. We must have missed something. Let's go over this again."
-> Driver_Start

==Door_not_open==
Rico spoke up "We are going to need to have the loading bay staff door unlocked if we are going to escape through that door."
He pointed at the map.
"It says here that the door is locked from the loading bay side."
The leader studied the map.
Kai mumbledunder his breath, " I'm sorry. I will make sure to unlock it for you guys."
The leader looked at Kai without moving his head. He then repositioned his body and looked around the table.
"It's okay Kai. Right you are Rico, we do need that door to be open. Let's go over this again to make sure we have the right plan down."
->Driver_Start

== Driver_End ==
" Okay so that is the plan for Kai. Any objections?"
{Car_Arrived == 0: ->Car_not_present}
{Costumes_Dropped_Off == 0: ->Costumes_not_dropped}
{Staff_Door_Unlocked == 0: ->Door_not_open}
"Good"
~ next_character()
-> Recon_Start

== Recon_Start ==
~next_end = ->Recon_End
The leader shifted his gaze towards Rico.  "Okay so Rico will be a sort of Recon agent there to help Jules steal the artifact. It will be your job to make it as easy as possible for Jules to get in and out."
-> Recon_End

== Distraction_not_created ==
Jules cleared her throat. "I'm going to need some kind of distraction in order to get through the vent into the staff hallways."
Rico piped up."I'm sure that I could take care of that some how."
Jules looked at Rico intensly."I'm sure that you can."
The Leader sighed. "Okay we are going to go over this one more time. Let's try to incorporate some kind of distraction into the plan"
->Recon_Start

== Guard_not_unconcious ==
Jules hesitantly spoke. "Uh how am I supposed to get a keycard to unlock the vault."
The leader looked at Jules and then back down at the map. "Let's see."
"There's usually a solitary guard in the staff hallways."
Rico excitedly chirped "I can totally knock that guy out."
The leader looked startled by Rico's happiness to knock a man unconcious.
He cleared his throat and collected himself.
"Okay lets go over this again and give Rico here a chance to flex his muscles this time."
->Recon_Start

== Cameras_not_off ==
Jules immediately got a bit irritated. "Come on guys if the cameras aren't off and erased then we are all going to get caught."
The leader gave a quick glance in Jules direction.
"Well you are the expert."
The leader looked around the table and then pointed at the map.
"The security room is in the staff halls. Rico should be able to get in there and shut of the cameras."
He pointed at the security room on the map.
Rico spoke up. "I can totally get that done."
The leader nodded his head. "Okay lets go over this again."

->Recon_Start

== Security_not_off ==
Jules sharply exhaled. "I can't steal from the vault unless the artifact security is turned off. To be more specific, I can't get the artifact out of it's glass casing without the security being tripped unless the security is shut off in advance."
The leader traced the vault on the map with his finger. He then drew a line from the vault to the security room. 
"The controls for the artifact security have to be in the security room. Rico!"
Rico perked up. "Uh yes sir!"
"You need to turn off the artifact security so that Jules can steal the artifact."
Rico nodded "Okay, I can do that."
->Recon_Start

==Recon_End==
"Any objections with Rico's part of the plan?"
"Ok, moving on"
~ next_character()
-> Thief_Start

==Thief_Start==
~next_end = ->Thief_End
"And finally we get to our resident procurement specialist. Jules, your job is to use the resources and oppurtunities that Rico and Kai set up to get into the museum's storage vault and steal the artifact."
-> Thief_End

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

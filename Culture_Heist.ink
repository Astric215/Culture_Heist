-> set_vars
//keep variables up here
==set_vars==
VAR timer = 0
VAR timer_default = 30
VAR has_costume = false
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
    {timer > 1: ->wait(-> postscript)}
    ->next_end

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

+[Go to the car dealership]
-> Car_Dealership

+[Go to the museum]
-> Outside

+[Go to the back of the museum] //only if you are the driver
-> Loading_Bay



//locations go below here
==Secret_Base==
The leader looked around the dark damp walls of the Secret base.
"You already know this place well obviously. Too bad we will have to be leaving it soon"
The leader sighed wistfully.
"Anyways let's get back to the plan."
The leader looked at {trait == Charismatic: Kai}{trait == Strong: Rico}{trait == Sneaky: Jules}.
"Okay {trait == Charismatic: Kai}{trait == Strong: Rico}{trait == Sneaky: Jules}. Here is the first thing you are going to do."

+[Leave the Base]"You are going to head out that door over there."
->Travel

+[Check watch]
    -(postscript)
        -> timer_text(-> done)
    -(done)
    -> Secret_Base //this needs to be different


->END

==Car_Dealership==
"You'll then go ahead and enter the car dealership. When you get there you'll notice several very expensive brands of cars parked out in front."
"The dealer, Gary, should be waiting inside. You'll be able to tell its him by his bushy red goatee."
"Gary runs a business that makes him a lot of money, and he certainly doesn't do it by selling brand new cars if you know what I mean." 
"If you can convince him our cause is worth it, he should be willing to give you a car with a less than legal history."

+[Ask to buy a stolen car]
{
-trait==Charismatic:
"With your charisma, that should be a piece of cake."
    ->Car_Dealership
-else:
"You won't need a second getaway vehicle, and even if you did there's no way you'd be able to convince him to give you another car. So back to the car dealership..."
    ->Car_Dealership
}

+[Go to the museum]
    ->Outside

+[Go to the Costume shop]
 ->Costume_Store
 
+[Go to the back of the museum]
{
-trait==Charismatic:
"You should be able to easily convince the guard out front that you're allowed to go back there."
    ->Loading_Bay
-else:
"You won't be able to get to the loading bay withought Kai's charisma."
    ->Car_Dealership
}

==Costume_Store==
"When you enter the costume store you'll likely be greeted by Burt, the store manager."
"Around the room you'll find your typical vampire fangs and devil horns, along with those horribly cheap couples mustard and ketchup costumes.
"But look hard enough and you may be able to sneak a peak behind Burts desk and see real police badges or forged signatures on several political documents."
"Burt is an interesting fellow. Tall, lanky, and not fast to trust new people. This may seem difficult to work with, but it's also why his side business is still in operation."

+[Acquire Security guard uniforms] //Only if you are the Driver
{
-trait==Charismatic:
"You should have no problem walking right up to Burt, convincing him to give you guard uniforms and forged ID's, and waltzing right back out in no time." 
    ->Costume_Store
-else:
"Thankfully Kai has already used their charm to gain the trust of Burt, so you won't need to get another set of security guard uniforms. Just pick them up from the mailroom where they dropped them off. So, you're in the costume store..."
    ->Costume_Store
}

+[Go to the museum]
    ->Outside
    
+[Go to the car dealership]
    ->Car_Dealership
    
+[Go to the back of the museum] //only if you are the driver
{
-trait==Charismatic:
"You should be able to easily convince the guard out front that you're allowed to go back there."
    ->Loading_Bay
-else:
"You won't be able to get to the loading bay withought Kai's charisma."
    ->Costume_Store
}


==Outside==
"Once you're outside the museum, you'll be able to see the two giant doors leading to the museum's front hall." 
"The museum also received a large grant recently, so you'll see the cheesy bushes shaped like famous statues out there as well."

+[Enter the museum]
    ->Museum_Entryway
    
+[Go to the car dealership]
    ->Car_Dealership
    
+[Go to the Costume shop]
 ->Costume_Store
 
+[Go to the back of the museum] //Only if you are the driver
    ->Loading_Bay

==Museum_Entryway==
"The entryway will be the easiest room to blend into due to the large number of museum-goers walking around and buying their tickets at the front desk." 
"There will likely be several groups of children incessantly blabbing about how they see boobies in every painting, or how 'Mindy's little brother keeps pulling on my hair.' So no need to worry about making too much noise either. The public's attention certainly won't be on you."
Recently, the museum announced its busiest year yet and the sudden influx can be attributed to the highly successful exhibitions. Averaging approximately over 30,000 visitors a day, the museum staff has been forced to close the exhibits for a day or two to meet about crowding and overworking conditions. Unlike the envisioned air-conditioned refuge you would imagine, the museum with its overcrowding gets uncomfortably warm and you can see countless numbers of visitors fanning themselves with maps and brochures as they race to find water fountains and seats.

+[Go to the Main Hall]
    ->Main_Hall

+[Exit the museum]
    ->Outside

==Main_Hall==
"This is where all of the less expensive artifacts are kept for public viewing."
"Against the eastern wall will be display cases filled with smaller pieces such as jewelry or fancy cutlery."
"Although they're displayed elegantly and locked up tight, most of these pieces are shitty replicas made with fake jewels. Even so, you'll still find people gawking at their beauty talking about how 'fascinating' and 'unique' they are."
 
+[Enter the art gallery]
    ->Side_Wing_1

+[Enter Statue Room]
    ->Side_Wing_2
    
+[Go to Entryway]
    ->Museum_Entryway

==Side_Wing_1==
"Probably the least exciting room of the museum, the art gallery is lined with benches in the center facing outwards towards the walls."
"The guards don't patrol this room as much as the others since it's usually just filled with old people taking a rest while their families leave them behind to rot alone."
"The only thing of value for us to note is the large metal gate on the northern end of the room that leads to the staff hallways." The museum staff opens that gate electronically to get artifacts out onto the museum floor. The gate itself is rather heavy.

+[Go through the metal gate] 
{
-trait==Strong:
"That's where you come in and use those muscles to lift the giant metal gate blocking the entrance to the staff hallways. Unfortunately it will shut behind you once you crawl under, but you can deal with that again if you need to." 
    ->Guard_Hall
-else:
"You wont be able to lift that".
    ->Side_Wing_1
}

+[Go to the Main Hall]
    ->Main_Hall

==Side_Wing_2==
"This wing of the museum is where the majority of the statues are displayed. Although most of the museum makes me shake my head, the statue room is weirdly comforting to me. Maybe it has something to do with my love of marble. Anyways the only important thing to note is the small vent on the north east end of the room.
Set up like a temple, the wing was decorated with sculptures that depicted scenes from mythology and cult, while the walls were constructed of gold and ivory. Some of these statues have been on permanent display for decades and on either end of the room you can see transepts. Even the walls are carved metopes. While it is universally recognized that the best seen and conserved sculptures are those that exist in museums, some of these pieces of art are symbols of power and of ancient pasts where the collection of antiquities have been transported outside of their respective countries.

+[Enter the vents to the Mailroom]
{
-trait==Sneaky:
"Thanks to your small frame you should be able to crawl through the air vents and find your way to the Mailroom."
    ->Mailroom
-else:
"Boss," {trait == Charismatic: Kai}{trait == Strong: Rico} chimes in, "There's absolutely no way I'll be able to fit through those vents. Maybe Jules could though?"
"All right then where were we..."
    ->Side_Wing_2
}

+[Go to the Main Hall]
    ->Main_Hall
    
==Mailroom==
"This is the mailroom where exhibits are shipped off and others are held before going on display. On the South end of the room is the door to the Loading Bay with a small mail slot next to it."

*[Pick up disguises]
"Thanks to Kai, your fake ID's and security guard uniforms have been placed, and are ready to be put on"
    ->Mailroom
    
+[Enter Guard Hall]
    ->Guard_Hall

+[Enter Vents to Side Hall 2]
    ->Side_Wing_2
{
-trait==Sneaky:
"You should be able to crawl right back through those vents."
    ->Side_Wing_2
-else:
"Boss," {trait == Charismatic: Kai}{trait == Strong: Rico} chimes in, "There's absolutely no way I'll be able to fit through those vents. Maybe Jules could though?"
"All right then where were we..."
    ->Mailroom
}
    
+[Enter Loading Bay]
->Loading_Bay

==Guard_Hall==
"There is a bit of a crossroads in the staff hallways. One of the halls will go north towards the Security room. The western hall will take you towards the vault. This hallway is a bit tricky though since in it locked off with a security door that can only be opened with a keycard that every guard carries. Finally the eastern hall will take you straight to the museum mail room. Since most traffic goes through this area, there should be a guard positioned there." 
The leader tapped the crossing corridors on the map. There is also a large metal gate here that goes out onto the museum floor. The gate is quite heavy. Anyways, back to the guard." 
{ 
    - Guard_Knocked_Out == 0:
    "The guard should be standing directly in the center of the crossroads."
    - Guard_Knocked_Out == timer:
        "You will get there just in time to see Rico knock out the guard."
    - timer < Guard_Knocked_Out:
        "By this point in time Rico will have already knocked out the guard. You will see the guard laying on the ground where Rico laid them out."
}

+[Go through the metal gate]
{
-trait==Strong:
"At this point you will go back into the museum proper through that gate. You will already have done this before by this point so it should be pretty easy for you. So, You'll just go ahead and lift that gate open one more time and head to the art gallery." 
    ->Side_Wing_1
-else:
"That gate will be way too heavy for you to lift. We are going to have to find a different way for you to get back into the museum proper."
    ->Guard_Hall
}

+[Go to the Mailroom]
    ->Mailroom
    
+{Guard_Knocked_Out >= timer}[Go to Security Room]
    {
-has_costume:
    ->Security_Room
-trait==Sneaky:
    Jules intensely stared and the map and then at the leader.
    "Why would it be a good idea at all for me to walk into a room filled with guards."
    The leader nodded. "You are right that isnt a good idea."
    ->Guard_Hall
-else:
Kai cuts the leader off "Wait wait wait. I didn't go through all that trouble grabbing that guard uniform for you to waltz into the Security Room looking like a convict." 
"They're right," Rico says, "If I'm gonna be going into the Security Room I'm gonna need to pick up The uniform Kai dropped off for me in the mailroom."
"All right then, so Rico, you don't go into the Security Room."
    ->Guard_Hall
}
    
+[Go towards the vault]
{
-has_keycard:
    ->Vault_Hall
-else:
    {trait == Strong: Rico}{trait == Sneaky: Jules} stops the boss "Wait wait wait, I'm gonna need a keycard to get in there first. Maybe the guard in this room will have one on them."
    ->Guard_Hall
}
+{Guard_Knocked_Out < timer} [Knock out the guard]
{
    -trait==Strong:
        The leader looked intensely at Rico.
        "Okay, so you are going to need to knock that guard out."
        Rico looked taken aback for a second but then nodded his head.
        "You got it, sir."
        ~Guard_Knocked_Out = timer
        ->Guard_Hall
    -else:
        Jules bit her fingernail. "There is no way that I are going to be able to overpower that guard. It is much better for me to wait for Rico to do it."
        The leader shook his head in agreement.
        ->Guard_Hall
}
+{Guard_Knocked_Out >= timer && has_keycard==false} [Take the guard's keycard]
    {
-trait==Strong:
Jules quickly spoke up. "Buddy, if Rico takes the keycard from the guard, what keycard am I going to use to get into the hallway leading to the vault."
The Leader furrowed his brow and thought about Jules' comment.
"You are right Jules. Rico will have to leave that card there."
->Guard_Hall
-else:
"You are going to go through that guard's pockets and get their keycard. Once you get the keycard off of that guard, you will finally have access to the hallway leading to the vault."
    ~has_keycard = true
    ->Guard_Hall
}
    

==Vault_Hall==
"By this point you will have finally found a way into the room with the safe But your work isn't done here!"

{ 
    - Cameras_Off == 0:
    "Thanks to Rico, the cameras should be fully disabled."
    - Cameras_Off == timer:
        "At that moment you'll be able to see the the camera's droop down towards the floor and the lights go off."
    - timer < Cameras_Off:
        "You can see a red light flashing near the cameras lense"
}

+[Walk up to the vault] //this needs the check to make sure the cameras are off before you can take this action
    ->Vault

==Vault==

[Open the Vault]
"You've finally done it. You're hands touch the artifact..."

->END

==Loading_Bay==
//Option 1 for when the getaway car is NOT set up 
"You'll then enter a huge warehouse with rows and rows of wooden crates and packing materials scattered about the floor."

//Option 2 for when the getaway car is set up
"You'll then enter a huge warehouse with rows and rows of wooden crates and packing materials scattered about the floor. There's a red sports car near the exit ready to leave when you are."

->END

==Security_Room==
"When you enter the Security Room you'll see computer screens lining the walls. To your left will be the button you'll have to press to turn off the motion sensors around the vault. Thankfully, you've already picked up your security guard uniform so being spotted won't be a problem."

+[Exit the Security Room]
    ->Guard_Hall

//the below nodes handle the meta conversation where the leader describes
//the plan or objections are raised to it. The format is Start, objects, End

== Driver_Start ==
~next_end = ->Driver_End
"Okay so Kai you are going to be the getaway driver."
The leader pointed at the map again.
"That means you won't be directly going into the museum. Instead you will organize disguises and get a car to the museum so the others can get out.'

-> Secret_Base
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
Kai mumbled under his breath, " I'm sorry. I will make sure to unlock it for you guys."
The leader looked at Kai without moving his head. He then repositioned his body and looked around the table.
"It's okay Kai. Right you are Rico, we do need that door to be open. Let's go over this again to make sure we have the right plan down."
->Driver_Start

== Driver_End ==
" Okay so that is the plan for Kai. Any objections?"
/*{Car_Arrived == 0: ->Car_not_present}
{Costumes_Dropped_Off == 0: ->Costumes_not_dropped}
{Staff_Door_Unlocked == 0: ->Door_not_open}*/
"Good"
~ next_character()
-> Recon_Start

== Recon_Start ==
~next_end = ->Recon_End
The leader shifted his gaze towards Rico.  "Okay so Rico will be a sort of Recon agent there to help Jules steal the artifact. It will be your job to make it as easy as possible for Jules to get in and out."
-> Secret_Base

== Distraction_not_created ==
Jules cleared her throat. "I'm going to need some kind of distraction in order to get through the vent into the staff hallways."
Rico piped up."I'm sure that I could take care of that somehow."
Jules looked at Rico intensely."I'm sure that you can."
The Leader sighed. "Okay we are going to go over this one more time. Let's try to incorporate some kind of distraction into the plan"
->Recon_Start

== Guard_not_unconcious ==
Jules hesitantly spoke. "Uh, how am I supposed to get a keycard to unlock the vault?"
The leader looked at Jules and then backed down at the map. "Let's see."
"There's usually a solitary guard in the staff hallways."
Rico excitedly chirped "I can totally knock that guy out."
The leader looked startled by Rico's happiness to knock a man unconscious.
He cleared his throat and collected himself.
"Okay let's go over this again and give Rico here a chance to flex his muscles this time."
->Recon_Start

== Cameras_not_off ==
Jules immediately got a bit irritated. "Come on guys if the cameras aren't off and erased then we are all going to get caught."
The leader gave a quick glance in Jules direction.
"Well you are the expert."
The leader looked around the table and then pointed at the map.
"The security room is in the staff halls. Rico should be able to get in there and shut off the cameras."
He pointed at the security room on the map.
Rico spoke up. "I can totally get that done."
The leader nodded his head. "Okay let's go over this again."

->Recon_Start

== Security_not_off ==
Jules sharply exhaled. "I can't steal from the vault unless the artifact security is turned off. To be more specific, I can't get the artifact out of its glass casing without the security being tripped unless the security is shut off in advance."
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
"And finally we get to our resident procurement specialist. Jules, your job is to use the resources and opportunities that Rico and Kai set up to get into the museum's storage vault and steal the artifact."
-> Secret_Base

==Thief_End==
"Does that plan sound good to everyone?"
"Then that is it"
-> Closing

== Closing ==
"Okay now that everyone knows their parts its time to get ready to leave. We only have until the artifact is transferred to pull this off. Lets go" 
The leader paused for one second.
"Good luck"
//check to demonstrate times being held
"Kai will get the car {Car_Arrived} minute{Car_Arrived > 1:s} before the heist is complete."
-> END

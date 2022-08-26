-> set_vars
//keep variables up here
==set_vars==
VAR timer = 0
VAR timer_default = 30
VAR has_costume = false
VAR has_car = false
VAR has_keycard = false

VAR next_end = ->introduction
VAR print_text = false
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

==function reset_vars==
~ has_costume = false
~ has_car = false
~ has_keycard = false
~ timer = timer_default

== timer_text(-> return_to_story) ==
-(postscript)
"At this point we would only have {timer} minutes to complete the heist."
->wait(-> posttext)
-(posttext)
->return_to_story
/*+ [Stop checking Watch]
    -> return_to_story

+ [Wait]
    {timer > 1: ->wait(-> postscript)}
    ->next_end*/

== wait(-> return_to) ==
"You are gonna stop there for a minute while checking your watch."
<-advance_time
-> return_to

== advance_time ==
~timer = timer - 1
{timer == 0: ->next_end}

== print_time ==
____________________{timer} minutes remaining____________________
{timer == 0: ->next_end}

== function next_character ==
~trait++
== introduction ==
“This year marks the five hundredth anniversary of the Spanish conquest of the Aztec Empire. In remembrance, Mexico has made numerous requests to retrieve a princess Aztec headdress from the United States, however they have been ignored and ridiculed. The United States denies Mexico’s request to reclaim their cultural heritage on the basis that the ancient relic is at risk of being damaged during transport. Thus, disallowing the request of reclamation to be fulfilled. As a valuable piece of the nation’s history, it is unclear as to how the ancient relic made its way thousands of miles to the mainland United States. And despite lawsuits having been underway for decades to reclaim the elaborate feather headdress believed to have been worn by an Aztec Emperor, Mexico continues to insist on bringing back the artifact to no avail. The United States has made the artifact into a major tourist attraction for the museum and continues to reappropriate the relic for its own gains. 

It is our job to help right the historical wrongs enacted by colonizers. The pillaging of artifacts must stop because it has been long overdue for material cultural heritage to be returned to its rightful and original owners. Museums will not listen to the pleas of the people to have them return archaeological artifacts, and the calls to restore cultural property to places of origin are constantly being ignored. These institutions and structures of power are steeped in historical colonial practice and old money. While some items end up in museum collections for reasons other than looting and theft, the Aztec artifact is a piece considered one of the most important historical relics in Mexico and its several requests for its return have been unsuccessful. The museum professionals are not “better qualified” to care for the artifact. These professionals making these judgements are white European men who cannot or will not acknowledge that disputes over cultural property are part of the decolonization of museums. They have been benefitting from a colonial past and it is due time to take ownership of their histories and return what is not theirs to its rightful owners. Whether it is voluntarily or involuntarily. 

That is where we come in. We need to take matters into our own hands. Mexican cultural heritage can no longer remain a prisoner of Western museums. These people have no right or claim to our cultural property. Yet, they continue to lock up our legacy and claim an entitlement to keep it despite knowing it was taken by colonial armies through what would now be considered as crimes against humanity.”


"So, here is the plan."
The leader tapped on the map of the museum.
"We are going to steal the Aztec artifact. We are going to run over this three times. Once for Kai our Charismatic escape driver. Once for Rico our strong support operator. And finally once for our sneaky thief Jules. As part of the plan we may need yall to check your watches to waste a minute waiting for the others to get into position. Try not to check them too often though, we don't want you to spend the whole heist looking at your watch."
 ~ next_character()

 "Are you ready to go over the plan?"
 * [Yes] "Good." 
 -> Driver_Start
 * [No] "Well too bad. We only have so much time."
-> Driver_Start

==Travel==
<-advance_time
-(start)
+[Go to the car dealership]
-> Car_Dealership

+[Go to the museum]
-> Outside

+[Go to the back of the museum] //only if you are the driver
-> Loading_Bay

+[Go to the Costume shop]
 ->Costume_Store
 
+[Go to the back of the museum]
{
-trait==Charismatic:
"You should be able to easily convince the guard out front that you're allowed to go back there."
"Just a few tips, avoid making eye contact with people who might recognize you and remember to keep your head low and walk calmly and slowly. It is better to look as if you're busy and as if you're on your way somewhere in particular with something to do. Be inconspicuous."
    ->Loading_Bay
-else:
"You won't be able to get to the loading bay withought Kai's charisma."
    ->start
}

//locations go below here
==Secret_Base==
-(start)
The leader looked around the dark damp walls of the Secret base.
"You already know this place well obviously. Too bad we will have to be leaving it soon"
The leader sighed wistfully.
"Anyways let's get back to the plan."
The leader looked at {trait == Charismatic: Kai}{trait == Strong: Rico}{trait == Sneaky: Jules}.
"Okay {trait == Charismatic: Kai}{trait == Strong: Rico}{trait == Sneaky: Jules}. Here is the first thing you are going to do."

-(posttext)
-(timeskip)
<-print_time 
+[Leave the Base]"You are going to head out that door over there."
->Travel

+[Check watch]
    -> timer_text(-> timeskip)


->END

==Car_Dealership==
-(start)
"You'll then go ahead and enter the car dealership. When you get there you'll notice several very expensive brands of cars parked out in front."
"The dealer, Gary, should be waiting inside. You'll be able to tell its him by his bushy red goatee."
"Gary runs a business that makes him a lot of money, and he certainly doesn't do it by selling brand new cars if you know what I mean." 
"If you can convince him our cause is worth it, he should be willing to give you a car with a less than legal history."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 

+[Buy the rundown buggy]
{trait == Charismatic: Kai}{trait == Strong: Rico}{trait == Sneaky: Jules} speaks up, "That's when I go up to the counter and ask how much that cute little yellow buggy I've had my eye on is."
The leader interjects, "I mean there's probably a better time for that but I guess you could???"
What are you looking at me for, {trait == Charismatic: Rico's}{trait == Strong: My}{trait == Sneaky: Rico's} niece has been wanting a car for forever now, so I thought I'd get it as a gift for her 18th birthday.
->posttext

+[Ask to buy a stolen car]
{
-trait==Charismatic && has_car==false:
"With your charisma, that should be a piece of cake."
“Just please make sure you don’t comment on his hair. I refuse to have a repeat of last time. He nearly took my head off when Ruth made a cheeky remark about how vibrant it looked and I swear I saw horns grow out of his head before he swung at me.”
    ~has_car = true
    ->posttext
-else:
"You won't need a second getaway vehicle, and even if you did there's no way you'd be able to convince him to give you another car. So back to the car dealership..."
    ->posttext
}

+[Leave the Car dealership]
    ->Travel

+[Check watch]
    -> timer_text(-> timeskip)
    
==Costume_Store==
-(start)
"When you enter the costume store you'll likely be greeted by Burt, the store manager."
You might notice that he is a little…quirky. However, do not underestimate him. He owns a legitimate costume shop but before that he was an arms dealer who went to the far corners of the world buying and trading valuables. Governments were put on waiting lists to discuss weapon and disguise sales with him in the past. So in a way he is basically a corporate lobbyist without the corporation.
"Around the room you'll find your typical vampire fangs and devil horns, along with those horribly cheap couples mustard and ketchup costumes.
"But look hard enough and you may be able to sneak a peak behind Burts desk and see real police badges or forged signatures on several political documents."
"Burt is an interesting fellow. Tall, lanky, and not fast to trust new people. This may seem difficult to work with, but it's also why his side business is still in operation."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 
+[Acquire Security guard uniforms] //Only if you are the Driver
{
-trait==Charismatic:
"You should have no problem walking right up to Burt, convincing him to give you guard uniforms and forged ID's, and waltzing right back out in no time."
    ~has_costume = true
    ->posttext
-else:
"Thankfully Kai has already used their charm to gain the trust of Burt, so you won't need to get another set of security guard uniforms. Just pick them up from the mailroom where they dropped them off. So, you're in the costume store..."
    ->posttext
}

+[Try on the {trait == Charismatic: sexy cop}{trait == Strong: banana}{trait == Sneaky: scary clown} costume]
{trait == Charismatic: Kai's face lights up, "If there's any sexy cop costumes I want to try one on!" Everyone at the table glares at Kai, "You know for fitting purposes... I've been working out a lot, gotta make sure my size hasn't chnged in case we take on another heist.}
{trait == Strong: "Hehe", Rico chuckles in his deep voice, "While I'm here can I try on one of those banana costumes? I always thought they looked so silly." Rico looks at the leader with puppy dog eyes and he replies, "Sure Rico, if it will make you happy."}
{trait == Sneaky: Jules speaks silently under her breath in embarrassment, "So I know we probably won't have much time for this, but since I'd already be at the costume shop... "The next few words spew out of her mouth in a rapid mumble", if they have any of those sick clown costumes I'd love to give myself a quick little scary clown makeover." The leader, shakes his head knowing he won't be able to change Jules' mind.}
->posttext

+[Leave the Costume store]
    ->Travel

+[Check watch]
    -> timer_text(-> timeskip)


==Outside==
-(start)
"Once you're outside the museum, you'll be able to see the two giant doors leading to the museum's front hall." 
"The museum also received a large grant recently, so you'll see the cheesy bushes shaped like famous statues out there as well."
"At first glance, the museum’s exterior seems to be made up of limestone and cubed lights. The squared arches reveal many panes of glass that obscure the ability to look in or out, and with the roofline filled with camp guard towers, the building was like a fortress. Home to a world-renowned collection, this was a landmark building that claims it is a place that welcomes everyone. Collection highlights include the world’s largest and most important collection of works by Black, Indigenous, and Latin American artists and with their featured extraordinary period rooms, the museum invites visitors to see the arts in varied ways."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 

+[Survey the area]
"
->posttext

+[Enter the museum]
    ->Museum_Entryway
    
+[Leave the museum]
    ->Travel
    
+[Check watch]
    -> timer_text(-> timeskip)

==Museum_Entryway==
-(start)
"The entryway will be the easiest room to blend into due to the large number of museum-goers walking around and buying their tickets at the front desk." 
"There will likely be several groups of children incessantly blabbing about how they see boobies in every painting, or how 'Mindy's little brother keeps pulling on my hair.' So no need to worry about making too much noise either. The public's attention certainly won't be on you."
"Recently, the museum announced its busiest year yet and the sudden influx can be attributed to the highly successful exhibitions. Averaging approximately over 30,000 visitors a day, the museum staff has been forced to close the exhibits for a day or two to meet about crowding and overworking conditions. Unlike the envisioned air-conditioned refuge you would imagine, the museum with its overcrowding gets uncomfortably warm and you can see countless numbers of visitors fanning themselves with maps and brochures as they race to find water fountains and seats. Blend in."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 

+[Go to the Main Hall]
    ->Main_Hall

+[Exit the museum]
    ->Outside
    
+[Check watch]
    -> timer_text(-> timeskip)

==Main_Hall==
-(start)
"This is where all of the less expensive artifacts are kept for public viewing."
"Against the eastern wall will be display cases filled with smaller pieces such as jewelry or fancy cutlery."
"Although they're displayed elegantly and locked up tight, most of these pieces are shitty replicas made with fake jewels. Even so, you'll still find people gawking at their beauty talking about how 'fascinating' and 'unique' they are."
 -(posttext)
<-advance_time
-(timeskip)
<-print_time 

+[Steal a trinket]
{trait == Charismatic: Kai}{trait == Strong: Rico}{trait == Sneaky: Jules} raises their hand, "If it's okay I'd like to steal something small while we're here. I know they're are all fake, but just knowing that copies of important pieces from our culture are out on display like that really bothers me." 
->posttext
 
+[Enter the art gallery]
    ->Side_Wing_1

+[Enter Statue Room]
    ->Side_Wing_2
    
+[Go to Entryway]
    ->Museum_Entryway
    
+[Check watch]
    -> timer_text(-> timeskip)

==Side_Wing_1==
-(start)
"Probably the least exciting room of the museum, the art gallery is lined with benches in the center facing outwards towards the walls."
"The guards don't patrol this room as much as the others since it's usually just filled with old people taking a rest while their families leave them behind to rot alone."
"The only thing of value for us to note is the large metal gate on the northern end of the room that leads to the staff hallways." The museum staff opens that gate electronically to get artifacts out onto the museum floor. The gate itself is rather heavy."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 

+[Take a seat on the bench and wait]
"While sitting on the bench you'll be able to see many paintings depicting the tragedies of some of our history. One of the largest paintings shows hundreds of Spaniards on horses surrounded by the bodies of men, women and children. Although the original artist was clearly of Aztec themself, throughought history this painting somehow ended up in the hands of a white man who was able to sell it to the museum for hundreds of thousands of dollars."
"A shame no one even sits here long enough to understand the cultural and historical value of these pieces of art."
->posttext

+[Go through the metal gate] 
{
-trait==Strong:
"That's where you come in and use those muscles to lift the giant metal gate blocking the entrance to the staff hallways. Unfortunately it will shut behind you once you crawl under, but you can deal with that again if you need to." 
"I hope that they are not just for show. Just try not to hurt yourself please. Any time you are upright and moving, you’re engaging the muscles in your core. The power, stability, and support generated from these muscles will help you move quicker and protect your lower back from injury. So avoid lifting with your back as well and try to only lift with your legs. We can’t have you hurting yourself on the job."
    ->Guard_Hall
-else:
"You won't be able to lift that."
"This is because lifting it is too heavy and can cause you muscle and joint damage as you are not trained to do this sort of heavy lifting. The dangers of lifting without proper training can cause spinal injuries such as herniated discs and in extreme cases, heavy lifting can even tear a heart artery, which could result in death. This is a load too heavy to lift and it is not worth putting a terrible strain on your body which can lead to painful muscle sprains and tears. You could even end up with a slipped disc or a hernia."
    ->posttext
}

+[Go to the Main Hall]
    ->Main_Hall
    
+[Check watch]
    -> timer_text(-> timeskip)

==Side_Wing_2==
-(start)
~print_text = true
"This wing of the museum is where the majority of the statues are displayed. Although most of the museum makes me shake my head, the statue room is weirdly comforting to me. Maybe it has something to do with my love of marble. Anyways the only important thing to note is the small vent on the north east end of the room.
"Set up like a temple, the wing was decorated with sculptures that depicted scenes from mythology and cult, while the walls were constructed of gold and ivory. Some of these statues have been on permanent display for decades and on either end of the room you can see transepts. Even the walls are carved metopes. While it is universally recognized that the best seen and conserved sculptures are those that exist in museums, some of these pieces of art are symbols of power and of ancient pasts where the collection of antiquities have been transported outside of their respective countries."
The boss pondered the statue layout for a second and then pointed at a staute on the map.
"This statue should create a neccesary distraction should something happen to it."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 
{
-timer > Distraction_Created && print_text:
    "The museum patrons will likely be drifting from statue to statue observing each one."
    Each statue has different representations in terms of their hand positioning, color and the items they may hold. So more often than not you can hear patrons trying to guess the deity and what the possible context behind the statues are. A lot of these statues range in different sizes, from small to big and even large with small size statues seemingly more difficult to craft and work on, so the quality of the work may not look as good as the work done on medium, or bigger statues but they are all very beautiful and impressive.
-timer == Distraction_Created:
    "You should be able to see Rico push over a statue. That will kick up quite the frenzy amongst the museum goers.It would not be uncommon for people to start yelling and shouting in this situation. Kids might feel inclined to pick up some of the falling debris or they may feel inspired to push a statue themselves. Some patrons might even believe this to be a part of an art show demonstration. But even if someone is caught ‘accidentally’ breaking the statue, historically, the museum will take their information not to collect on the damage but to issue a full report to the insurance company so that they can get a check for their imminent claim."
-timer < Distraction_Created  && (print_text || timer == Distraction_Created - 1):
    "Most museum patrons should be crowding the statue that Rico will have knocked over by this point. Any guards in the area will likely be dealing with that as well. This means that all eyes will be on that statue."
}
<-print_time 
~print_text = false
+[Enter the vents to the Mailroom]
{
-timer <= Distraction_Created:
    {
    -trait==Sneaky:
    "Thanks to your small frame you should be able to crawl through the air vents and find your way to the Mailroom."
        ->Mailroom
    -else:
    "Boss," {trait == Charismatic: Kai}{trait == Strong: Rico} chimes in, "There's absolutely no way I'll be able to fit through those vents. Maybe Jules could though?"
    The leader knodded.
    "All right then where were we..."
        ->posttext
    }
-else:
    " We are going to have to plan around that vent. There is certainly no way for you to get through it with all the museum patrons in the statue room. There is going to have to be some kind of distraction for you to slip in unnoticed."
    ->posttext
}

+{timer > Distraction_Created} [Push over a statue]
    {
    -trait==Strong:
    "With your big muscles you should be able to push over a statue with minimal effort. Once you do that the museum patrons should be distracted enough to let Jules climb through the vent."
    ~Distraction_Created = timer
        ->posttext
    -else:
    "You wont be strong enough to push a statue over. So we will have to wait for Rico to do it."
        ->posttext
    }

+[Go to the Main Hall]
    ->Main_Hall
    
+[Check watch]
    -> timer_text(-> timeskip)
    
==Mailroom==
-(start)
"Temporary exhibitions often include objects that have been borrowed and will later be returned to their owner, calling for a mailroom that doubles as a shipping store. Most of the objects on display are from the museum’s own personal collections so usually those would just go back into storage, however objects that are specifically acquired for an exhibition may require curator perk and revealing the security movement would be equivalent to divulging trade secrets. Early museums were often founded as ways for wealthy collectors to show off what they had acquired to less fortunate people and help to “educate” them. And unfortunately, that still stands to this day. On the North end of the room is the door to the Loading Bay with a small mail slot next to it."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 

+{has_costume==false}[Pick up disguises]
{
-Costumes_Dropped_Off > timer:
    "Thanks to Kai, your fake ID and security guard uniform will have been placed, and will be ready to be put on"
    ~has_costume = true
        ->posttext
-Costumes_Dropped_Off == timer:
    "You should see the guard disguises slip into the mailslot at that moment. You would then grab one and put in on"
    ~has_costume = true
        ->posttext
-else:
    "Unfortunately, you will have to wait for Kai to deliver the costumes before retrieving them."
    ->posttext
}

+[Enter Guard Hall]
    ->Guard_Hall

+[Enter Vents to the Statue room]
    ->Side_Wing_2
{
-trait==Sneaky:
"You should be able to crawl right back through those vents."
    ->Side_Wing_2
-else:
"Boss," {trait == Charismatic: Kai}{trait == Strong: Rico} chimes in, "There's absolutely no way I'll be able to fit through those vents. Maybe Jules could though?"
"All right then where were we..."
    ->posttext
}
    
+[Enter Loading Bay]
->Loading_Bay

+[Check watch]
    -> timer_text(-> timeskip)

==Guard_Hall==
-(start)
~print_text = true
“The guard hall is the part of the building with the guards on assigned shifts in accordance with safety and security rules and regulations. More often than not, you can find the guards patrolling and performing a variety of custodial duties like contact with maintenance crews, law enforcement officials, and the general public to maintain security. This work is performed under the supervision of a higher level guard and positions vary depending on the assigned shift. These are the guards in charge of preventing theft in the building and allowing only authorized material in and out of the building while maintaining the entry/exit register.”

"There is a bit of a crossroads in the staff hallways. One of the halls will go north towards the Security room. The western hall will take you towards the vault. This hallway is a bit tricky though since in it locked off with a security door that can only be opened with a keycard that every guard carries. Finally the eastern hall will take you straight to the museum mail room. Since most traffic goes through this area, there should be a guard positioned there." 
The leader tapped the crossing corridors on the map. There is also a large metal gate here that goes out onto the museum floor. The gate is quite heavy. Anyways, back to the guard."
-(posttext)
<-advance_time
-(timeskip)

{ 
    - Guard_Knocked_Out < timer && print_text:
    "The guard should be standing directly in the center of the crossroads."
    - Guard_Knocked_Out == timer:
        "You will get there just in time to see Rico knock out the guard."
    - timer < Guard_Knocked_Out   && (print_text || timer == Guard_Knocked_Out - 1):
        "By this point in time Rico will have already knocked out the guard. You will see the guard laying on the ground where Rico laid them out."
}
<-print_time 
~print_text = false

+[Go through the metal gate]
{
-trait==Strong:
"At this point you will go back into the museum proper through that gate. You will already have done this before by this point so it should be pretty easy for you. So, You'll just go ahead and lift that gate open one more time and head to the art gallery." 
    ->Side_Wing_1
-else:
"That gate will be way too heavy for you to lift. We are going to have to find a different way for you to get back into the museum proper."
    ->posttext
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
    ->posttext
-else:
Kai cuts the leader off "Wait wait wait. I didn't go through all that trouble grabbing that guard uniform for you to waltz into the Security Room looking like a convict." 
"They're right," Rico says, "If I'm gonna be going into the Security Room I'm gonna need to pick up The uniform Kai dropped off for me in the mailroom."
"All right then, so Rico, you don't go into the Security Room."
    ->posttext
}
    
+[Go towards the vault]
{
-has_keycard:
    ->Vault_Hall
-else:
    {trait == Strong: Rico}{trait == Sneaky: Jules} stops the boss "Wait wait wait, I'm gonna need a keycard to get in there first. Maybe the guard in this room will have one on them."
    ->posttext
}
+{Guard_Knocked_Out < timer} [Knock out the guard]
{
    -trait==Strong:
        The leader looked intensely at Rico.
        "Okay, so you are going to need to knock that guard out."
        Rico looked taken aback for a second but then nodded his head.
        "You got it, sir."
        ~Guard_Knocked_Out = timer
        ->posttext
    -else:
        Jules bit her fingernail. "There is no way that I are going to be able to overpower that guard. It is much better for me to wait for Rico to do it."
        The leader shook his head in agreement.
        ->posttext
}
+{Guard_Knocked_Out >= timer && has_keycard==false} [Take the guard's keycard]
    {
-trait==Strong:
Jules quickly spoke up. "Buddy, if Rico takes the keycard from the guard, what keycard am I going to use to get into the hallway leading to the vault."
The Leader furrowed his brow and thought about Jules' comment.
"You are right Jules. Rico will have to leave that card there."
->posttext
-else:
"You are going to go through that guard's pockets and get their keycard. Once you get the keycard off of that guard, you will finally have access to the hallway leading to the vault."
    ~has_keycard = true
    ->posttext
}

+[Check watch]
    -> timer_text(-> timeskip)

==Vault_Hall==
-(start)
~print_text = true
"By this point you will have finally found a way into the hallway to the safe But your work isn't done here! This hallway is filled with security cameras so you are going to have some issue moving through the area without being caught."
"At nearly all museums, what you see on public display is but a tiny taste of what they have to offer. Gallery space may be limited but basements and off-site storage are usually used to hold artifacts to make up for the lack of space. The vault is essential for this. The museum’s storage area is a peak of what happens in a museum beyond what has been pre-curated for viewing.This is where the Aztec artifact is held at. The vault is like the heart of the museum, but unlike its other displays, it is a large and inaccessible storage that serves as not just a practical asset but also the building’s central design component. It is a gray structure made of tens of millions of pounds of concrete sitting in the middle of the building with cameras installed at every possible angle of every entrance and exit. As a secure space, the vault protects its contents with armored walls and a tightly fashioned door closed with a complex lock."
-(posttext)
<-advance_time
-(timeskip)
{ 
    - Cameras_Off > timer  && (print_text || timer == Cameras_Off - 1):
    "Thanks to Rico, the cameras should be fully disabled."
    - Cameras_Off == timer:
        "At that moment you'll be able to see the the camera's droop down towards the floor and the lights go off."
    - timer > Cameras_Off && print_text:
        "You can see a red light flashing near the cameras lense"
}
<-print_time 
~print_text = false

+[Walk up to the vault] //this needs the check to make sure the cameras are off before you can take this action
{
    -Cameras_Off >= timer:
        ->Vault
    -else:
        "You wont be able to make it down the hall without having those cameras off. If you try with them still on then you will surely be caught. You will have to wait for Rico to turn off cameras."
        ->posttext
}
    
+[Check watch]
    -> timer_text(-> timeskip)

==Vault==
-(start)
~print_text = true
-(posttext)
<-advance_time
-(timeskip)
{ 
    - Security_Off < timer && print_text:
    "There should be a blinking light that indicates that the vault security is on. You will have to wait for it to be off to open the vault."
    - Security_Off == timer:
        "You should see the light for the vault security turn off."
    - timer < Security_Off  && (print_text || timer == Security_Off - 1):
        "By this point in time Rico will have already turned off the security so the security light should be off."
}
<-print_time 
~print_text = false

+{Security_Off <= timer}[Open the Vault]
    "At that point you will have finally done it. You're hands will touch the artifact and you will be able to get it out of there."
    ->Closing
    
+[Check watch]
    -> timer_text(-> timeskip)
    
==Loading_Bay==
-(start)
~print_text = true
"You'll then enter a huge warehouse with rows and rows of wooden crates and packing materials scattered about the floor. There will also be a mailslot that leads to the mailroom of the museum. The final thing that you will notice is this door."
The leader tapped a door on the map.
"This door is typically locked to prevent traffic between the museum staff halls and the loading bay so it will need to be unlocked for us."
The leader tapped the loading bay on the map.
"This is where you will meet up for your getaway."
-(posttext)
<-advance_time
-(timeskip)

{Car_Arrived >= timer && (print_text || timer == Car_Arrived): "There will be a red sports car parked near the exit ready to leave when you are."}
<-print_time 
~print_text = false

+{has_car && Car_Arrived < timer} [Park car in the loading bay]
    "You are going to leave the car there so all of you can use it later."
    ~Car_Arrived = timer
    ->posttext

+{Staff_Door_Unlocked < timer} [Unlock the staff door]
    ~Staff_Door_Unlocked = timer
    ->posttext

+[Go into the mailroom]
{
-Staff_Door_Unlocked < timer:
    "Hmmmmm. The door will still be locked by that point so we cant have you going through yet."
    ->posttext
-trait == Charismatic:
    "Kai, we don't need you to go into the museum hallways themselves so it is a better idea for you to wait and get ready to driver the others out."
    Kai quickly nodded their head.
    "You got it."
    ->posttext
-else:
    ->Mailroom
}

+{has_costume && trait==Charismatic}[Drop off the guard disguise]
    "You are going to slip the guard disguise into the mailslot for Rico to pick up."
    ~has_costume = false
    ~Costumes_Dropped_Off = timer
    ->posttext
"You'll then enter a huge warehouse with rows and rows of wooden crates and packing materials scattered about the floor."
+[Wait for the others and Escape]
    ->next_end

+[Leave the museum]
    ->Travel

+[Check watch]
    -> timer_text(-> timeskip)
    
-->END

==Security_Room==
-(start)
"When you enter the Security Room you'll see computer screens lining the walls. To your left will be the button you'll have to press to turn off the motion sensors and cameras around the vault. Thankfully, you've already picked up your security guard uniform so being spotted won't be a problem."
-(posttext)
<-advance_time
-(timeskip)
<-print_time 

+{Cameras_Off < timer}[Turn off the cameras]
    "You will have to inconspicuously walk up to the camera controls and stop their recording. Once that is done then Jules should be able to approach the vault."
    ~Cameras_Off = timer
    ->posttext
    
+{Security_Off < timer}[Turn off the Vault Security]
    "You will have to walk towards the artifact security controls and shut off the motion sensors in the vault. Onece that is done Jules should be able to retrieve the artifact."
    ~Security_Off = timer
    ->posttext
    
+[Exit the Security Room]
    ->Guard_Hall

+[Check watch]
    -> timer_text(-> timeskip)
    
//the below nodes handle the meta conversation where the leader describes
//the plan or objections are raised to it. The format is Start, objects, End

== Driver_Start ==
~ Car_Arrived = 0
~ Costumes_Dropped_Off = 0
~ Staff_Door_Unlocked = 0
~ reset_vars()
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
Kai mumbled under his breath, "I'm sorry. I will make sure to unlock it for you guys."
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
~ Distraction_Created = 0
~ Guard_Knocked_Out = 0
~ Cameras_Off = 0
~ Security_Off = 0
~ reset_vars()
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
{Distraction_Created == 0: ->Distraction_not_created}
{Guard_Knocked_Out == 0: ->Guard_not_unconcious}
{Cameras_Off == 0: ->Cameras_not_off}
{Security_Off == 0: ->Security_not_off}
"Ok, moving on"
~ next_character()
-> Thief_Start

==Thief_Start==
~ reset_vars()
~next_end = ->Thief_End
"And finally we get to our resident procurement specialist. Jules, your job is to use the resources and opportunities that Rico and Kai set up to get into the museum's storage vault and steal the artifact."
-> Secret_Base

==Thief_End==
"Does that plan sound good to everyone?"
"Then that is it"
-> Closing

== Closing ==
"Okay now that everyone knows their parts its time to get ready to leave. We only have until the artifact is put on display to pull this off. We need to get the artifact out of there before then. Lets return this important piece of culture to its people. Lets go everyone.
The leader paused for one second.
"Good luck"
Everyone nodded and left the secret base to carry out the plan.
-> END

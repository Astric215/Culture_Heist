//keep variables up here
VAR timer = 30
-> introduction

=== timer_text(-> return_to) ===
"At this point we would only have {timer} minutes to complete the heist."
-> return_to

=== introduction ===
"So, here is the plan."
The leader tapped on the map of the museum.
"We are going to steal the [insert here]."

-(postscript)
 -> timer_text(-> done)
-(done)
 * [There] were two choices. -> Driver_Start
 * There were four lines of content.

- They lived happily ever after.
    -> END

=== Driver_Start ===
"Okay so Kai you are going to be the getaway driver"
The leader pointed at the map again.
"That means you won't be direcly going into the museum. Instead you will organise disguises and get a car to the museum so the others can get out.'


-> END
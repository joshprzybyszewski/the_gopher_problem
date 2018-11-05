# the_gopher_problem
Present and discover answers to the gopher problem.

# Riddle
You have five holes in your yard. You know that a gopher lives in one of them, and they are arranged in a line:

Hole 1 | Hole 2 | Hole 3 | Hole 4 | Hole 5
:-:|:-:|:-:|:-:|:-:
? | ? | ? | ? | ?

Every day at noon, you go out and you stab a single hole with a stake.

Every night the gopher _must_ move holes, to either the right or left. 

## Question
**What is the fewest number of days you can guarantee the gopher is dead?**

_And what is the sequence of hole stabbings to provide that guarantee?_


## Quick clarifications

You do not know which hole the gopher occupies on Day 1.

If the gopher is on the end, he must move inwards; he cannot wrap around from Hole 1 to Hole 5 or vice versa.

Upon stabbing, you've either killed the gopher or you remove the stake and wait a day.

The gopher _could_ choose to move in any sequence. For example, if you stab Hole 3 every day, the gopher could move from Hole 1 to 2 to 1, and back and forth forever, like so:

| - | Hole 1 | Hole 2 | Hole 3 | Hole 4 | Hole 5
-|:-:|:-:|:-:|:-:|:-:
DAY 1 | G | O | X | O | O
DAY 2 | O | G | X | O | O
DAY 3 | G | O | X | O | O

# Solutions
See READMEs of subfolders for solutions.

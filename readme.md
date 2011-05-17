FlockingClumps, or Clumpers
=====

### Steven Klise <http://stevenklise.com>
### Nature of Code, Spring 2011, ITP
### Taught by Daniel Shiffman <http://shiffman.net>

#### _FlockingClumps is an experiment of combining flocking behaviors with cellular automaton like rules without discrete boundaries between organisms._

My intention with Clumpers was to see what would happen when a cellular automaton was removed from a grid and give the organisms the ability to move and interact. What emergent qualities would result by combining two systems each with their own emergent qualities?

The program starts with a few hundred organisms spawning at random throughout the screen. Each individual organism then looks for the average position of all the organisms, as well as the average heading of the organisms within a smaller neighborhood. These two values are scaled and combined to a desired velocity. On top of these calculated velocities a random movement is added to maintain a variety in the movements of the organisms.

At the same time as these steering behaviors, each organism is counting the number of neighbors it has. If that number is above a 'crowded' threshold or below a 'loneliness' threshold the organism dies. Upon death the organism leaves behind a ripple and is reborn at a random location on the screen. My original intention was to have organisms born in locations based on the density of living organisms, just like a cellular automata. However, without clear boundaries between organisms it proved difficult to get a global density map for where to spawn new organisms.

Video of FlockingClumps: http://vimeo.com/23694777
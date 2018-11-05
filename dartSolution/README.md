# Dart Solution

I implemented the solution using [Dartlang](https://www.dartlang.org/), since it was familiar to me and quick to implement.

Run this solution with ```dart main.dart```. You will get a print out of the set of states and outgoing edges. It will also write to the python file createKripkeGraph.g.py. You can run this python file to make a graphical representation of the Kripke structure it generated (this png graph isn't great -- I just found the quickest thing I could on the interwebs).

## CTL Solution
I used [CTL (Computational Tree Logic)](https://en.wikipedia.org/wiki/Computation_tree_logic) to solve this problem. I did so by creating a [Kripke structure](https://en.wikipedia.org/wiki/Kripke_structure_(model_checking)) to create a graph of States. Each State represents the complete list of holes the gopher could possibly be occupying at 11:59am on a given day. Each Edge represents which hole is stabbed at noon.

### Brief logic discussion
1. First, assume the following:
   - _D_ = {1, 2, 3, ...}, is a numbering of days. 
   - _E_ = {1, 2, 3, ..., n}, is the set of of edges
   - _S_ = {"12345", "1234", "1235", ..., "4", "5", "dead"}, is the set of complete lists of possible holes the gopher could occupy. 
   - _S(d)_ is the set of States for a given Day _d_
   - _s0_ is from _S_, and is the starting State "12345". This means that the gopher could be living in any of the holes on the first day of the problem.
   - Day _d_ is called today.
2. Consider some State _s(d)_ from _S(d)_, and some edge _e_ from _E_.
3. Plainly, State _s(d)_ is the complete list of possible holes the gopher could exist in at 11:59am today.
4. Consider the State _sOther_ which is reached along Edge _e_.
5. Plainly, _sOther_ is the complete list of possible holes the gopher could occupy after I stab Hole _e_ today at noon.
6. In other words, _sOther_ is the complete list of possible holes the gopher could occupy at 11:59am tomorrow.
7. Clearly, _sOther_ is from _S(d+1)_.

The goal is to build a Kripke structure starting from _s0_. If the structure has the "dead" state, then we know the problem is solvable, and we must find the shortest path from _s0_ to "dead".

We can easily build this Kripke structure by passing in our starting state, and iteratively create next states. That is, keep an "unvisited nodes" list, initialized to _s0_. Then iterate through the "unvisited nodes", and at each node iterate through all possible outgoing edges to create a destination node (which we add to "unvisited nodes" if we haven't seen it before).

Here's the pseudo-code for what I'm describing:
```
unvisited = ['12345']
visited = []
while unvisited.isNotEmpty {
  state = unvisited.remove()
  visited.add(state)
  for Edge e = 1..5 {
    nextState = state.getDestinationAlong(e)
    state.addEdge(e, nextState)
    if !visited.contains(nextState) && !unvisited.contains(nextState) {
      unvisited.add(nextState)
    }
  }
}
```

## So now we have a Kripke structure
You can manually see the shortest path from _s0_ to "dead", or you could input it to a model checking software (like [SPIN](http://spinroot.com)) and running it against the following CTL statements until you find your shortest path:
1. EX("dead")
2. EX(EX("dead"))
3. EX(EX(EX("dead")))
4. ... 

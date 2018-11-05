/// [State] represents a node in the Kripke structure
class State {
  /// [possibleHoles] encapsulates the holes the gopher could be living in
  final Set<int> possibleHoles;

  /// [outgoingEdges] is the list of hole-stabbings to next states for this node
  Map<String, State> outgoingEdges = {};

  State(this.possibleHoles);

  /// [name] is the unique node name
  String get name => possibleHoles.isNotEmpty ? (possibleHoles.toList()..sort()).join("") : 'dead';

  /// [getNextState] creates the state which would be reached along the outgoing
  ///  edge labeled [guess], for a gopher problem with [n] holes
  State getNextState(int guess, int n) {
    Set<int> possibleNexts = new Set<int>();
    for (int i in possibleHoles) {
      if (i == guess) continue;

      if (i > 1) possibleNexts.add(i - 1);

      if (i < n) possibleNexts.add(i + 1);
    }

    return new State(possibleNexts);
  }

  /// [addOutgoingEdge] adds the destination state [dest] for this node along the outgoing edge labeled [guess]
  /// 
  /// This will remove duplicate edges by checking to see if we've reached the destination already, and 
  /// adding this new guess to the edge label.
  void addOutgoingEdge(int guess, State dest) {
    String edgeName = '$guess';
    for (String existingEdge in outgoingEdges.keys) {
      State existingDest = outgoingEdges[existingEdge];
      if (existingDest.name == dest.name) {
        edgeName = '$guess$existingEdge';
        outgoingEdges.remove(existingEdge);
        break;
      }
    }

    outgoingEdges[edgeName] = dest;
  }
}

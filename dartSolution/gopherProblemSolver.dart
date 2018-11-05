import 'dart:io';

import 'state.dart';

/// [GopherProblemSolver] provides utilities for solving the gopher problem
class GopherProblemSolver {
  /// [pythonGraphFileName] is the name of python file we will write the graph to
  static String pythonGraphFileName = 'createKripkeGraph.g.py';

  /// [solve] solves the given gopher problem, with 5 holes
  static void solve() {
    solveN(5);
  }

  /// [solveN] solves the gopher problem for a given number of holes
  static void solveN(int n) {
    Map<String, State> visitedStates = {};
    Map<String, State> unvisitedStates = {};

    Set<int> initialHoles = new Set<int>();
    for (int i = 1; i <= n; i++) initialHoles.add(i);
    var initialState = new State(initialHoles);

    unvisitedStates[initialState.name] = initialState;

    while (unvisitedStates.keys.isNotEmpty) {
      var firstKey = unvisitedStates.keys.first;
      var stateToProcess = unvisitedStates.remove(firstKey);
      visitedStates[stateToProcess.name] = stateToProcess;

      for (int holeChoice = 1; holeChoice <= n; holeChoice++) {
        var nextState = stateToProcess.getNextState(holeChoice, n);

        if (!visitedStates.containsKey(nextState.name) &&
            !unvisitedStates.containsKey(nextState.name)) {
          unvisitedStates[nextState.name] = nextState;
        }

        stateToProcess.addOutgoingEdge(holeChoice, nextState);
      }
    }

    printStates(visitedStates);
    writePython(visitedStates);
  }

  /// [printStates] prints each state, and the edges by which it reaches other states
  static void printStates(Map<String, State> visitedStates) {
    for (String key in visitedStates.keys) {
      print("State: $key");
      State s = visitedStates[key];
      for (String edge in s.outgoingEdges.keys) {
        State dest = s.outgoingEdges[edge];
        print("  --$edge--> ${dest.name}");
      }
    }
  }

  /// [writePython] writes a python file for drawing a graph
  static void writePython(Map<String, State> visitedStates) {
    var pythonCode = '''import networkx as nx
import matplotlib.pyplot as plt
G=nx.DiGraph()
''';
    visitedStates.forEach((_, v) {
      v.outgoingEdges.forEach((edgeName, dest) {
        pythonCode += 'G.add_edge("${v.name}", "${dest.name}", name="$edgeName" )\n';
      });
    });
    pythonCode += '''

colors = []
for node in G.nodes(data=True):
    if (node[0] == "dead"):
        colors.append("r")
    else:
        colors.append("g")

edge_labels = {}
for edge in G.edges(data=True):
    edge_labels[(edge[0], edge[1])] = edge[2]["name"]

pos=nx.spring_layout(G)
nx.draw_networkx(G, pos=pos, node_shape="s", node_color=colors)
nx.draw_networkx_edge_labels(G, pos=pos, edge_labels=edge_labels)

plt.savefig("kripkeGraph.png")
''';

    new File(pythonGraphFileName).writeAsString(pythonCode);
  }
}
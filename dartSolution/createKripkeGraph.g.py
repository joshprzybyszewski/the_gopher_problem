import networkx as nx
import matplotlib.pyplot as plt
G=nx.DiGraph()
G.add_edge("12345", "2345", name="2" )
G.add_edge("12345", "1234", name="4" )
G.add_edge("12345", "12345", name="531" )
G.add_edge("2345", "2345", name="2" )
G.add_edge("2345", "1345", name="3" )
G.add_edge("2345", "1234", name="4" )
G.add_edge("2345", "12345", name="51" )
G.add_edge("1234", "2345", name="2" )
G.add_edge("1234", "1235", name="3" )
G.add_edge("1234", "1234", name="4" )
G.add_edge("1234", "12345", name="51" )
G.add_edge("1345", "24", name="4" )
G.add_edge("1345", "2345", name="5321" )
G.add_edge("1235", "24", name="2" )
G.add_edge("1235", "1234", name="5431" )
G.add_edge("24", "35", name="2" )
G.add_edge("24", "13", name="4" )
G.add_edge("24", "135", name="531" )
G.add_edge("135", "24", name="54321" )
G.add_edge("35", "4", name="3" )
G.add_edge("35", "24", name="5421" )
G.add_edge("13", "2", name="3" )
G.add_edge("13", "24", name="5421" )
G.add_edge("4", "dead", name="4" )
G.add_edge("4", "35", name="5321" )
G.add_edge("2", "dead", name="2" )
G.add_edge("2", "13", name="5431" )
G.add_edge("dead", "dead", name="54321" )

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

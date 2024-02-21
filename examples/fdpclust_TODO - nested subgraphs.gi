# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/undirected/fdpclust.html"""

LoadPackage("graphviz");

g := GV_Graph("G");
GV_SetAttr(g, "engine=\"fdp\"");

GV_AddNode(g, "e");

clusterA := GV_AddSubgraph(g, IsGVGraph, "clusterA");
GV_AddEdge(clusterA, "a", "b");

with g.subgraph(name='clusterA') as a:
    a.edge('a', 'b')
    with a.subgraph(name='clusterC') as c:
        c.edge('C', 'D')

with g.subgraph(name='clusterB') as b:
    b.edge('d', 'f')

g.edge('d', 'D')
g.edge('e', 'clusterB')
g.edge('clusterC', 'clusterB')

g.view()
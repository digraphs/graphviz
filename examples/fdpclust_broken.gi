# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/undirected/fdpclust.html"""

LoadPackage("graphviz");

g := GV_Graph("G");
GV_SetAttr(g, "engine=\"fdp\"");

GV_AddNode(g, "e");

a := GV_AddSubgraph(g, "clusterA");
GV_AddEdge(a, "a", "b");

c := GV_Subgraph(a, "clusterC");
GV_AddEdge(g, "C", "D");

b := GV_AddSubgraph(g, "clusterB");
GV_AddEdge(g, "d", "f");

GV_AddEdge(g, "d", "D");
GV_AddEdge(g, "e", "clusterB");
GV_AddEdge(g, "clusterC", "clusterB");

Print(GV_String(g));

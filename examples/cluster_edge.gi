# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/pdf/dotguide.pdf, Figure 20"""

LoadPackage("graphviz");

g := GV_Digraph("G");
GV_SetAttr(g, "compound=true");

cluster0 := GV_AddSubgraph(g, IsGVDigraph, "cluster0");
GV_AddEdge(cluster0, "a", "b");
GV_AddEdge(cluster0, "a", "c");
GV_AddEdge(cluster0, "b", "d");
GV_AddEdge(cluster0, "c", "d");


cluster1 := GV_AddSubgraph(g, IsGVDigraph, "cluster1");
GV_AddEdge(cluster1, "e", "g");
GV_AddEdge(cluster1, "e", "f");

GV_SetAttr(GV_AddEdge(g, "b", "f"), "lhead", "cluster1");
GV_AddEdge(g, "d", "e");

e := GV_AddEdge(g, "c", "g");
GV_SetAttr(e, "ltail", "cluster0");
GV_SetAttr(e, "lhead", "cluster1");

e := GV_AddEdge(g, "c", "e");
GV_SetAttr(e, "ltail", "cluster0");

GV_AddEdge(g, "d", "h");

Print(GV_String(g));

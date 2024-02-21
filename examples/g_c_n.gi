# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/gradient/g_c_n.html"""

LoadPackage("graphviz");

g := GV_Graph("G");
GV_SetAttr(g, "bgcolor=\"purple:pink\" label=\"agraph\" fontcolor=\"white\"");
cluster1 := GV_AddSubgraph(g, IsGVGraph, "cluster1");
GV_SetAttr(cluster1, "fillcolor=\"blue:cyan\" label=\"acluster\" fontcolor=\"white\" style=\"filled\" gradientangle=270\n");
GV_SetAttr(cluster1, "node [shape=box, fillcolor=\"red:yellow\", style=\"filled\", gradientangle=90]");
GV_AddNode(cluster1, "anode");

Print(GV_String(g));

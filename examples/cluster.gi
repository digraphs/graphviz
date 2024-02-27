# https://graphviz.readthedocs.io/en/stable/examples.html
LoadPackage("graphviz");
graph := GV_Digraph("G");

cluster0 := GV_AddSubgraph(graph, "cluster_0");
GV_SetAttr(cluster0, "color=\"lightgrey\"");
GV_SetAttr(cluster0, "style=\"filled\"");
GV_SetAttr(cluster0, "node [color=\"white\", style=\"filled\"]");
GV_AddEdge(cluster0, "a0", "a1");
GV_AddEdge(cluster0, "a1", "a2");
GV_AddEdge(cluster0, "a2", "a3");
GV_SetAttr(cluster0, "label=\"process #1\"");

cluster1 := GV_AddSubgraph(graph, "cluster_1");
GV_SetAttr(cluster1, "color=\"blue\"");
GV_SetAttr(cluster1, "node [style=\"filled\"]");
GV_AddEdge(cluster1, "b0", "b1");
GV_AddEdge(cluster1, "b1", "b2");
GV_AddEdge(cluster1, "b2", "b3");
GV_SetAttr(cluster1, "label=\"process #2\"");

GV_AddEdge(graph, "start", "a0");
GV_AddEdge(graph, "start", "b0");
GV_AddEdge(graph, "a1", "b3");
GV_AddEdge(graph, "b2", "a3");
GV_AddEdge(graph, "a3", "a0");
GV_AddEdge(graph, "a3", "end");
GV_AddEdge(graph, "b3", "end");

GV_SetAttr(graph["start"], "shape", "Mdiamond");
GV_SetAttr(graph["end"], "shape", "Msquare");

Print(GV_String(graph));

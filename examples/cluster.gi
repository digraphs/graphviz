# https://graphviz.readthedocs.io/en/stable/examples.html
LoadPackage("graphviz");
graph := GraphvizDigraph("G");

cluster0 := GraphvizAddSubgraph(graph, "cluster_0");
GraphvizSetAttr(cluster0, "color=\"lightgrey\"");
GraphvizSetAttr(cluster0, "style=\"filled\"");
GraphvizSetAttr(cluster0, "node [color=\"white\", style=\"filled\"]");
GraphvizAddEdge(cluster0, "a0", "a1");
GraphvizAddEdge(cluster0, "a1", "a2");
GraphvizAddEdge(cluster0, "a2", "a3");
GraphvizSetAttr(cluster0, "label=\"process #1\"");

cluster1 := GraphvizAddSubgraph(graph, "cluster_1");
GraphvizSetAttr(cluster1, "color=\"blue\"");
GraphvizSetAttr(cluster1, "node [style=\"filled\"]");
GraphvizAddEdge(cluster1, "b0", "b1");
GraphvizAddEdge(cluster1, "b1", "b2");
GraphvizAddEdge(cluster1, "b2", "b3");
GraphvizSetAttr(cluster1, "label=\"process #2\"");

GraphvizAddEdge(graph, "start", "a0");
GraphvizAddEdge(graph, "start", "b0");
GraphvizAddEdge(graph, "a1", "b3");
GraphvizAddEdge(graph, "b2", "a3");
GraphvizAddEdge(graph, "a3", "a0");
GraphvizAddEdge(graph, "a3", "end");
GraphvizAddEdge(graph, "b3", "end");

GraphvizSetAttr(graph["start"], "shape", "Mdiamond");
GraphvizSetAttr(graph["end"], "shape", "Msquare");

Print(AsString(graph));

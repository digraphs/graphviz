# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/pdf/dotguide.pdf, Figure 20"""

LoadPackage("graphviz");

g := GraphvizDigraph("G");
GraphvizSetAttr(g, "compound=true");

cluster0 := GraphvizAddSubgraph(g, "cluster0");
GraphvizAddEdge(cluster0, "a", "b");
GraphvizAddEdge(cluster0, "a", "c");
GraphvizAddEdge(cluster0, "b", "d");
GraphvizAddEdge(cluster0, "c", "d");

cluster1 := GraphvizAddSubgraph(g, "cluster1");
GraphvizAddEdge(cluster1, "e", "g");
GraphvizAddEdge(cluster1, "e", "f");

GraphvizSetAttr(GraphvizAddEdge(g, "b", "f"), "lhead", "cluster1");
GraphvizAddEdge(g, "d", "e");

e := GraphvizAddEdge(g, "c", "g");
GraphvizSetAttr(e, "ltail", "cluster0");
GraphvizSetAttr(e, "lhead", "cluster1");

e := GraphvizAddEdge(g, "c", "e");
GraphvizSetAttr(e, "ltail", "cluster0");

GraphvizAddEdge(g, "d", "h");

Print(AsString(g));

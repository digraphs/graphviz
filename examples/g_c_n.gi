# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/gradient/g_c_n.html"""

LoadPackage("graphviz");

g := GraphvizGraph("G");
GraphvizSetAttr(g, "bgcolor=\"purple:pink\" label=\"agraph\" fontcolor=\"white\"");
cluster1 := GraphvizAddSubgraph(g, "cluster1");
GraphvizSetAttr(cluster1, "fillcolor=\"blue:cyan\" label=\"acluster\" fontcolor=\"white\" style=\"filled\" gradientangle=270\n");
GraphvizSetAttr(cluster1, "node [shape=box, fillcolor=\"red:yellow\", style=\"filled\", gradientangle=90]");
GraphvizAddNode(cluster1, "anode");

Print(AsString(g));

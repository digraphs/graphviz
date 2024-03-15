# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/gradient/angles.html"""

LoadPackage("graphviz");
g := GraphvizDigraph("G");
GraphvizSetAttr(g, "bgcolor", "blue");

cluster1 := GraphvizAddSubgraph(g, "cluster_1");
GraphvizSetAttr(cluster1, "fontcolor", "white");
GraphvizSetAttr(cluster1, "node[shape=circle, style=filled, fillcolor=\"white:black\", gradientangle=360, label=\"n9:n360\", fontcolor=black]");
GraphvizAddNode(cluster1, "n9");


pairs := ListN([8,7..1], [315,270..0], {x, y} -> [x, y]);
for pair in pairs do
    node := GraphvizAddNode(cluster1, StringFormatted("n{}", pair[1]));
    GraphvizSetAttr(node, "gradientangle", StringFormatted("{}", pair[2]));
    GraphvizSetAttr(node, "label", StringFormatted("\"n{}:{}\"", pair[1], pair[2]));
od;
GraphvizSetAttr(cluster1, "label", "\"Linear Angle Variations (white to black gradient)\"");


cluster2 := GraphvizAddSubgraph(g, "cluster_2");
GraphvizSetAttr(cluster2, "fontcolor", "white");
GraphvizSetAttr(cluster2, "node[shape=circle, style=radial, fillcolor=\"white:black\", gradientangle=360, label=\"n9:n360\", fontcolor=black]");
GraphvizAddNode(cluster2, "n18");

pairs := ListN([17,16..10], [315,270..0], {x, y} -> [x, y]);
for pair in pairs do
    node := GraphvizAddNode(cluster2, StringFormatted("n{}", pair[1]));
    GraphvizSetAttr(node, "gradientangle", StringFormatted("{}", pair[2]));
    GraphvizSetAttr(node, "label", StringFormatted("\"n{}:{}\"", pair[1], pair[2]));
od;
GraphvizSetAttr(cluster2, "label", "\"Radial Angle Variations (white to black gradient)\"");

GraphvizAddEdge(g, "n5", "n14");
Print(AsString(g));

# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/gradient/angles.html"""

LoadPackage("graphviz");
g := GV_Digraph("G");
GV_SetAttr(g, "bgcolor", "blue");

cluster1 := GV_AddSubgraph(g, "cluster_1");
GV_SetAttr(cluster1, "fontcolor", "white");
GV_SetAttr(cluster1, "node[shape=circle, style=filled, fillcolor=\"white:black\", gradientangle=360, label=\"n9:n360\", fontcolor=black]");
GV_AddNode(cluster1, "n9");


pairs := ListN([8,7..1], [315,270..0], {x, y} -> [x, y]);
for pair in pairs do
    node := GV_AddNode(cluster1, StringFormatted("n{}", pair[1]));
    GV_SetAttr(node, "gradientangle", StringFormatted("{}", pair[2]));
    GV_SetAttr(node, "label", StringFormatted("\"n{}:{}\"", pair[1], pair[2]));
od;
GV_SetAttr(cluster1, "label", "\"Linear Angle Variations (white to black gradient)\"");


cluster2 := GV_AddSubgraph(g, "cluster_2");
GV_SetAttr(cluster2, "fontcolor", "white");
GV_SetAttr(cluster2, "node[shape=circle, style=radial, fillcolor=\"white:black\", gradientangle=360, label=\"n9:n360\", fontcolor=black]");
GV_AddNode(cluster2, "n18");

pairs := ListN([17,16..10], [315,270..0], {x, y} -> [x, y]);
for pair in pairs do
    node := GV_AddNode(cluster2, StringFormatted("n{}", pair[1]));
    GV_SetAttr(node, "gradientangle", StringFormatted("{}", pair[2]));
    GV_SetAttr(node, "label", StringFormatted("\"n{}:{}\"", pair[1], pair[2]));
od;
GV_SetAttr(cluster2, "label", "\"Radial Angle Variations (white to black gradient)\"");

GV_AddEdge(g, "n5", "n14");
Print(GV_String(g));

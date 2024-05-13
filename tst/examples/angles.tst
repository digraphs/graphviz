#############################################################################
##
##  examples/angles.tst
##  Copyright (C) 2024                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://www.graphviz.org/Gallery/gradient/angles.html

#@local cluster1, cluster2, g, node, pair, pairs
gap> START_TEST("graphviz package: examples/angles.tst");
gap> LoadPackage("graphviz");
true
gap> g := GraphvizDigraph("G");
<graphviz digraph G with 0 nodes and 0 edges>
gap> GraphvizSetAttr(g, "bgcolor", "blue");
<graphviz digraph G with 0 nodes and 0 edges>
gap> cluster1 := GraphvizAddSubgraph(g, "cluster_1");
<graphviz digraph cluster_1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(cluster1, "fontcolor", "white");
<graphviz digraph cluster_1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(cluster1, Concatenation("node[shape=circle, style=filled,",
> "fillcolor=\"white:black\", gradientangle=360, label=\"n9:n360\",",
> "fontcolor=black]"));
<graphviz digraph cluster_1 with 0 nodes and 0 edges>
gap> GraphvizAddNode(cluster1, "n9");
<graphviz node n9>
gap> pairs := ListN([8, 7 .. 1], [315, 270 .. 0], {x, y} -> [x, y]);
[ [ 8, 315 ], [ 7, 270 ], [ 6, 225 ], [ 5, 180 ], [ 4, 135 ], [ 3, 90 ], 
  [ 2, 45 ], [ 1, 0 ] ]
gap> for pair in pairs do
>     node := GraphvizAddNode(cluster1, StringFormatted("n{}", pair[1]));
>     GraphvizSetAttr(node, "gradientangle", StringFormatted("{}", pair[2]));
>     GraphvizSetAttr(node, "label",
>                     StringFormatted("\"n{}:{}\"", pair[1], pair[2]));
> od;
gap> GraphvizSetAttr(cluster1,
>                 "label",
>                 "Linear Angle Variations (white to black gradient)");
<graphviz digraph cluster_1 with 9 nodes and 0 edges>
gap> cluster2 := GraphvizAddSubgraph(g, "cluster_2");
<graphviz digraph cluster_2 with 9 nodes and 0 edges>
gap> GraphvizSetAttr(cluster2, "fontcolor", "white");
<graphviz digraph cluster_2 with 9 nodes and 0 edges>
gap> GraphvizSetAttr(cluster2, Concatenation("node[shape=circle, style=radial,",
>                 "fillcolor=\"white:black\", gradientangle=360,",
>                 "label=\"n9:n360\", fontcolor=black]"));
<graphviz digraph cluster_2 with 9 nodes and 0 edges>
gap> GraphvizAddNode(cluster2, "n18");
<graphviz node n18>
gap> pairs := ListN([17, 16 .. 10], [315, 270 .. 0], {x, y} -> [x, y]);
[ [ 17, 315 ], [ 16, 270 ], [ 15, 225 ], [ 14, 180 ], [ 13, 135 ], 
  [ 12, 90 ], [ 11, 45 ], [ 10, 0 ] ]
gap> for pair in pairs do
>     node := GraphvizAddNode(cluster2, StringFormatted("n{}", pair[1]));
>     GraphvizSetAttr(node, "gradientangle", StringFormatted("{}", pair[2]));
>     GraphvizSetAttr(node, "label", StringFormatted("\"n{}:{}\"",
>                     pair[1], pair[2]));
> od;
gap> GraphvizSetAttr(cluster2, "label",
>                 "Radial Angle Variations (white to black gradient)");
<graphviz digraph cluster_2 with 18 nodes and 0 edges>
gap> GraphvizAddEdge(g, "n5", "n14");
<graphviz edge (n5, n14)>

#@if CompareVersionNumbers(GAPInfo.Version, "4.12.0")
gap> Print(AsString(g));
//dot
digraph G {
	bgcolor=blue 
subgraph cluster_1 {
	fontcolor=white node[shape=circle, style=filled,fillcolor="white:black", grad\
ientangle=360, label="n9:n360",fontcolor=black] label="Linear Angle Variations\
 (white to black gradient)" 
	n9
	n8 [gradientangle=315, label="n8:315"]
	n7 [gradientangle=270, label="n7:270"]
	n6 [gradientangle=225, label="n6:225"]
	n5 [gradientangle=180, label="n5:180"]
	n4 [gradientangle=135, label="n4:135"]
	n3 [gradientangle=90, label="n3:90"]
	n2 [gradientangle=45, label="n2:45"]
	n1 [gradientangle=0, label="n1:0"]
}
subgraph cluster_2 {
	fontcolor=white node[shape=circle, style=radial,fillcolor="white:black", grad\
ientangle=360,label="n9:n360", fontcolor=black] label="Radial Angle Variations\
 (white to black gradient)" 
	n18
	n17 [gradientangle=315, label="n17:315"]
	n16 [gradientangle=270, label="n16:270"]
	n15 [gradientangle=225, label="n15:225"]
	n14 [gradientangle=180, label="n14:180"]
	n13 [gradientangle=135, label="n13:135"]
	n12 [gradientangle=90, label="n12:90"]
	n11 [gradientangle=45, label="n11:45"]
	n10 [gradientangle=0, label="n10:0"]
}
	n5 -> n14
}
#@else
gap> Print(AsString(g));
//dot
digraph G {
	bgcolor=blue 
subgraph cluster_1 {
	fontcolor=white node[shape=circle, style=filled,fillcolor="white:black", grad\
ientangle=360, la\
bel="n9:n360",fontcolor=black] label="Linear Angle Variations (white to black \
gradient)" 
	n9
	n8 [gradientangle=315, label="n8:315"]
	n7 [gradientangle=270, label="n7:270"]
	n6 [gradientangle=225, label="n6:225"]
	n5 [gradientangle=180, label="n5:180"]
	n4 [gradientangle=135, label="n4:135"]
	n3 [gradientangle=90, label="n3:90"]
	n2 [gradientangle=45, label="n2:45"]
	n1 [gradientangle=0, label="n1:0"]
}
subgraph cluster_2 {
	fontcolor=white node[shape=circle, style=radial,fillcolor="white:black", grad\
ientangle=360,lab\
el="n9:n360", fontcolor=black] label="Radial Angle Variations (white to black \
gradient)" 
	n18
	n17 [gradientangle=315, label="n17:315"]
	n16 [gradientangle=270, label="n16:270"]
	n15 [gradientangle=225, label="n15:225"]
	n14 [gradientangle=180, label="n14:180"]
	n13 [gradientangle=135, label="n13:135"]
	n12 [gradientangle=90, label="n12:90"]
	n11 [gradientangle=45, label="n11:45"]
	n10 [gradientangle=0, label="n10:0"]
}
	n5 -> n14
}
#@fi

#
gap> STOP_TEST("graphviz package: angles.tst");

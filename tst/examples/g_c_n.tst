#############################################################################
##
##  g_c_n.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://www.graphviz.org/Gallery/gradient/g_c_n.html

#@local cluster1, g
gap> START_TEST("graphviz package: examples/g_c_n.tst");
gap> LoadPackage("graphviz");
true

#
gap> g := GraphvizGraph("G");
<graphviz graph G with 0 nodes and 0 edges>
gap> GraphvizSetAttr(g,
> "bgcolor=\"purple:pink\" label=\"agraph\" fontcolor=\"white\"");
<graphviz graph G with 0 nodes and 0 edges>
gap> cluster1 := GraphvizAddSubgraph(g, "cluster1");
<graphviz graph cluster1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(cluster1, Concatenation(
> "fillcolor=\"blue:cyan\" label=\"acluster\" fontcolor=\"white\"",
> "style=\"filled\" gradientangle=270\n"));
<graphviz graph cluster1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(cluster1, Concatenation(
> "node [shape=box, fillcolor=\"red:yellow\",",
> " style=\"filled\", gradientangle=90]"));
<graphviz graph cluster1 with 0 nodes and 0 edges>
gap> GraphvizAddNode(cluster1, "anode");
<graphviz node anode>

#@if CompareVersionNumbers(GAPInfo.Version, "4.12.0")
gap> Print(String(g));
//dot
graph G {
	bgcolor="purple:pink" label="agraph" fontcolor="white" 
subgraph cluster1 {
	fillcolor="blue:cyan" label="acluster" fontcolor="white"style="filled" gradie\
ntangle=270
 node [shape=box, fillcolor="red:yellow", style="filled", gradientangle=90] 
	anode
}
}
#@else
gap> Print(String(g));
//dot
graph G {
	bgcolor="purple:pink" label="agraph" fontcolor="white" 
subgraph cluster1 {
	fillcolor="blue:cyan" label="acluster" fontcolor="white"style="filled" gradie\
n\
tangle=270
 node [shape=box, fillcolor="red:yellow", style="filled", gradientangle=90] 
	anode
}
}
#@fi

#
gap> STOP_TEST("graphviz package: g_c_n.tst");

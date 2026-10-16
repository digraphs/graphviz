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
gap> LoadPackage("GraphvizForGAP");
true

#
gap> g := GraphvizGraph("G");
<graphviz graph "G" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(g, rec(bgcolor := "purple:pink", label := "agraph", fontcolor := "white"));
<graphviz graph "G" with 0 nodes and 0 edges>
gap> cluster1 := GraphvizAddSubgraph(g, "cluster1");
<graphviz graph "cluster1" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(cluster1,
> rec(fillcolor := "blue:cyan", label := "acluster", fontcolor := "white",
> style := "filled", gradientangle := 270));
<graphviz graph "cluster1" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(cluster1,
> rec(node := rec(shape := "box", fillcolor := "red:yellow", style := "filled",
> gradientangle := 90)));
<graphviz graph "cluster1" with 0 nodes and 0 edges>
gap> GraphvizAddNode(cluster1, "anode");
<graphviz node "anode">
gap> Print(AsString(g), "\n");
//dot
graph G {
  graph [bgcolor="purple:pink", fontcolor="white", label="agraph"]
  subgraph cluster1 {
    graph [fillcolor="blue:cyan", fontcolor="white", gradientangle="270", labe\
l="acluster", style="filled"]
    node [fillcolor="red:yellow", gradientangle="90", shape="box", style="fill\
ed"]
    anode
  }
}

#
gap> STOP_TEST("graphviz package: examples/g_c_n.tst");

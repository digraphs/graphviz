#############################################################################
##
##  cluster_edge.tst
##  Copyright (C) 2024                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://www.graphviz.org/pdf/dotguide.pdf, Figure 20

#@local cluster0, cluster1, e, g
gap> START_TEST("graphviz package: examples/cluster_edge.tst");
gap> LoadPackage("graphviz");
true

#
gap> g := GraphvizDigraph("G");
<graphviz digraph G with 0 nodes and 0 edges>
gap> GraphvizSetAttr(g, "compound=true");
<graphviz digraph G with 0 nodes and 0 edges>
gap> cluster0 := GraphvizAddSubgraph(g, "cluster0");
<graphviz digraph cluster0 with 0 nodes and 0 edges>
gap> GraphvizAddEdge(cluster0, "a", "b");
<graphviz edge (a, b)>
gap> GraphvizAddEdge(cluster0, "a", "c");
<graphviz edge (a, c)>
gap> GraphvizAddEdge(cluster0, "b", "d");
<graphviz edge (b, d)>
gap> GraphvizAddEdge(cluster0, "c", "d");
<graphviz edge (c, d)>
gap> cluster1 := GraphvizAddSubgraph(g, "cluster1");
<graphviz digraph cluster1 with 0 nodes and 0 edges>
gap> GraphvizAddEdge(cluster1, "e", "g");
<graphviz edge (e, g)>
gap> GraphvizAddEdge(cluster1, "e", "f");
<graphviz edge (e, f)>
gap> GraphvizSetAttr(GraphvizAddEdge(g, "b", "f"), "lhead", "cluster1");
<graphviz edge (b, f)>
gap> GraphvizAddEdge(g, "d", "e");
<graphviz edge (d, e)>
gap> e := GraphvizAddEdge(g, "c", "g");
<graphviz edge (c, g)>
gap> GraphvizSetAttr(e, "ltail", "cluster0");
<graphviz edge (c, g)>
gap> GraphvizSetAttr(e, "lhead", "cluster1");
<graphviz edge (c, g)>
gap> e := GraphvizAddEdge(g, "c", "e");
<graphviz edge (c, e)>
gap> GraphvizSetAttr(e, "ltail", "cluster0");
<graphviz edge (c, e)>
gap> GraphvizAddEdge(g, "d", "h");
<graphviz edge (d, h)>
gap> AsString(g);
"//dot\ndigraph G {\n\tcompound=true \nsubgraph cluster0 {\n\ta\n\tb\n\ta -> b\
\n\tc\n\ta -> c\n\td\n\tb -> d\n\tc -> d\n}\nsubgraph cluster1 {\n\te\n\tg\n\t\
e -> g\n\tf\n\te -> f\n}\n\tb -> f [lhead=cluster1]\n\td -> e\n\tc -> g [lhead\
=cluster1, ltail=cluster0]\n\tc -> e [ltail=cluster0]\n\th\n\td -> h\n}\n"

#
gap> STOP_TEST("graphviz package: cluster_edge.tst");

#############################################################################
##
##  btree.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/unix.html

#@local s
gap> START_TEST("graphviz package: examples/btree.tst");
gap> LoadPackage("graphviz");
true

#
gap> s := GraphvizDigraph("g");
<graphviz digraph g with 0 nodes and 0 edges>
gap> GraphvizSetAttr(s, "node [shape=record, height=.1]");
<graphviz digraph g with 0 nodes and 0 edges>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node0"), "label", "<f0> |<f1> G|<f2>");
<graphviz node node0>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node1"), "label", "<f0> |<f1> E|<f2>");
<graphviz node node1>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node2"), "label", "<f0> |<f1> B|<f2>");
<graphviz node node2>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node3"), "label", "<f0> |<f1> F|<f2>");
<graphviz node node3>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node4"), "label", "<f0> |<f1> R|<f2>");
<graphviz node node4>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node5"), "label", "<f0> |<f1> H|<f2>");
<graphviz node node5>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node6"), "label", "<f0> |<f1> Y|<f2>");
<graphviz node node6>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node7"), "label", "<f0> |<f1> A|<f2>");
<graphviz node node7>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node8"), "label", "<f0> |<f1> C|<f2>");
<graphviz node node8>
gap> GraphvizAddEdge(s, "node0:f2", "node4:f1");
<graphviz edge (node0:f2, node4:f1)>
gap> GraphvizAddEdge(s, "node0:f0", "node1:f1");
<graphviz edge (node0:f0, node1:f1)>
gap> GraphvizAddEdge(s, "node1:f0", "node2:f1");
<graphviz edge (node1:f0, node2:f1)>
gap> GraphvizAddEdge(s, "node1:f2", "node3:f1");
<graphviz edge (node1:f2, node3:f1)>
gap> GraphvizAddEdge(s, "node2:f2", "node8:f1");
<graphviz edge (node2:f2, node8:f1)>
gap> GraphvizAddEdge(s, "node2:f0", "node7:f1");
<graphviz edge (node2:f0, node7:f1)>
gap> GraphvizAddEdge(s, "node4:f2", "node6:f1");
<graphviz edge (node4:f2, node6:f1)>
gap> GraphvizAddEdge(s, "node4:f0", "node5:f1");
<graphviz edge (node4:f0, node5:f1)>
gap> AsString(s) =
> "//dot\ndigraph g {\n\tnode [shape=record, height=.1] \n\tnode0 [label=\"<f0> \
> |<f1> G|<f2>\"]\n\tnode1 [label=\"<f0> |<f1> E|<f2>\"]\n\tnode2 [label=\"<f0> \
> |<f1> B|<f2>\"]\n\tnode3 [label=\"<f0> |<f1> F|<f2>\"]\n\tnode4 [label=\"<f0> \
> |<f1> R|<f2>\"]\n\tnode5 [label=\"<f0> |<f1> H|<f2>\"]\n\tnode6 [label=\"<f0> \
> |<f1> Y|<f2>\"]\n\tnode7 [label=\"<f0> |<f1> A|<f2>\"]\n\tnode8 [label=\"<f0> \
> |<f1> C|<f2>\"]\n\tnode0:f2\n\tnode4:f1\n\tnode0:f2 -> node4:f1\n\tnode0:f0\n\
> \tnode1:f1\n\tnode0:f0 -> node1:f1\n\tnode1:f0\n\tnode2:f1\n\tnode1:f0 -> node\
> 2:f1\n\tnode1:f2\n\tnode3:f1\n\tnode1:f2 -> node3:f1\n\tnode2:f2\n\tnode8:f1\n\
> \tnode2:f2 -> node8:f1\n\tnode2:f0\n\tnode7:f1\n\tnode2:f0 -> node7:f1\n\tnode\
> 4:f2\n\tnode6:f1\n\tnode4:f2 -> node6:f1\n\tnode4:f0\n\tnode5:f1\n\tnode4:f0 -\
> > node5:f1\n}\n";
true

#
gap> STOP_TEST("graphviz package: btree.tst");

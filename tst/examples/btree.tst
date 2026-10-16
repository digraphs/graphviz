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
gap> LoadPackage("GraphvizForGAP");
true

#
gap> s := GraphvizDigraph("g");
<graphviz digraph "g" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(s, rec(node := rec(shape := "record", height := ".1")));
<graphviz digraph "g" with 0 nodes and 0 edges>
gap> GraphvizSetAttr(GraphvizAddNode(s, "node0"), "label", "<f0> |<f1> G|<f2>");
<graphviz node "node0">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node1"), "label", "<f0> |<f1> E|<f2>");
<graphviz node "node1">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node2"), "label", "<f0> |<f1> B|<f2>");
<graphviz node "node2">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node3"), "label", "<f0> |<f1> F|<f2>");
<graphviz node "node3">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node4"), "label", "<f0> |<f1> R|<f2>");
<graphviz node "node4">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node5"), "label", "<f0> |<f1> H|<f2>");
<graphviz node "node5">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node6"), "label", "<f0> |<f1> Y|<f2>");
<graphviz node "node6">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node7"), "label", "<f0> |<f1> A|<f2>");
<graphviz node "node7">
gap> GraphvizSetAttr(GraphvizAddNode(s, "node8"), "label", "<f0> |<f1> C|<f2>");
<graphviz node "node8">
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
gap> Print(AsString(s), "\n");
//dot
digraph g {
  node [height=".1", shape="record"]
  node0 [label="<f0> |<f1> G|<f2>"]
  node1 [label="<f0> |<f1> E|<f2>"]
  node2 [label="<f0> |<f1> B|<f2>"]
  node3 [label="<f0> |<f1> F|<f2>"]
  node4 [label="<f0> |<f1> R|<f2>"]
  node5 [label="<f0> |<f1> H|<f2>"]
  node6 [label="<f0> |<f1> Y|<f2>"]
  node7 [label="<f0> |<f1> A|<f2>"]
  node8 [label="<f0> |<f1> C|<f2>"]
  node0:f2
  node4:f1
  node0:f2 -> node4:f1
  node0:f0
  node1:f1
  node0:f0 -> node1:f1
  node1:f0
  node2:f1
  node1:f0 -> node2:f1
  node1:f2
  node3:f1
  node1:f2 -> node3:f1
  node2:f2
  node8:f1
  node2:f2 -> node8:f1
  node2:f0
  node7:f1
  node2:f0 -> node7:f1
  node4:f2
  node6:f1
  node4:f2 -> node6:f1
  node4:f0
  node5:f1
  node4:f0 -> node5:f1
}

#
gap> STOP_TEST("graphviz package: btree.tst");

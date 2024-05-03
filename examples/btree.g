#############################################################################
##
##  btree.g
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/unix.html
LoadPackage("graphviz");

s := GraphvizDigraph("g");
GraphvizSetAttr(s, "node [shape=record, height=.1]");

GraphvizSetAttr(GraphvizAddNode(s, "node0"), "label", "<f0> |<f1> G|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node1"), "label", "<f0> |<f1> E|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node2"), "label", "<f0> |<f1> B|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node3"), "label", "<f0> |<f1> F|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node4"), "label", "<f0> |<f1> R|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node5"), "label", "<f0> |<f1> H|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node6"), "label", "<f0> |<f1> Y|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node7"), "label", "<f0> |<f1> A|<f2>");
GraphvizSetAttr(GraphvizAddNode(s, "node8"), "label", "<f0> |<f1> C|<f2>");

GraphvizAddEdge(s, "node0:f2", "node4:f1");
GraphvizAddEdge(s, "node0:f0", "node1:f1");
GraphvizAddEdge(s, "node1:f0", "node2:f1");
GraphvizAddEdge(s, "node1:f2", "node3:f1");
GraphvizAddEdge(s, "node2:f2", "node8:f1");
GraphvizAddEdge(s, "node2:f0", "node7:f1");
GraphvizAddEdge(s, "node4:f2", "node6:f1");
GraphvizAddEdge(s, "node4:f0", "node5:f1");

Print(AsString(s));
Splash(s);
QUIT;

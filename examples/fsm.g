#############################################################################
##
##  fsm.g
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/fsm.html
LoadPackage("graphviz");

f := GraphvizDigraph("finite_state_machine");
GraphvizSetAttr(f, "rankdir=LR");
GraphvizSetAttr(f, "size=\"8,5\"");

terminals := GraphvizAddContext(f, "terminals");
GraphvizSetAttr(terminals, "node [shape=doublecircle]");
GraphvizAddNode(terminals, "LR_0");
GraphvizAddNode(terminals, "LR_3");
GraphvizAddNode(terminals, "LR_4");
GraphvizAddNode(terminals, "LR_8");

nodes := GraphvizAddContext(f, "nodes");
GraphvizSetAttr(nodes, "node [shape=circle]");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_2"), "label", "\"SS(B)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_1"), "label", "\"SS(S)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_1", "LR_3"), "label", "\"S($end)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_6"), "label", "\"SS(b)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_5"), "label", "\"SS(a)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_4"), "label", "\"S(A)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_7"), "label", "\"S(b)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_5"), "label", "\"S(a)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_6"), "label", "\"S(b)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_5"), "label", "\"S(a)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_8"), "label", "\"S(b)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_5"), "label", "\"S(a)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_6"), "label", "\"S(b)\"");
GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_5"), "label", "\"S(a)\"");

Print(AsString(f));
Splash(f);
QUIT;

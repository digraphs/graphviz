#############################################################################
##
##  fsm.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/fsm.html

#@local f, nodes, terminals
gap> START_TEST("graphviz package: examples/fsm.tst");
gap> LoadPackage("GraphvizForGAP");
true

#
gap> f := GraphvizDigraph("finite_state_machine");
<graphviz digraph "finite_state_machine" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(f, rec(rankdir := "LR"));
<graphviz digraph "finite_state_machine" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(f, rec(size := "8,5"));
<graphviz digraph "finite_state_machine" with 0 nodes and 0 edges>

#
gap> terminals := GraphvizAddContext(f, "terminals");
<graphviz context "terminals" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(terminals, rec(node := rec(shape := "doublecircle")));
<graphviz context "terminals" with 0 nodes and 0 edges>
gap> GraphvizAddNode(terminals, "LR_0");
<graphviz node "LR_0">
gap> GraphvizAddNode(terminals, "LR_3");
<graphviz node "LR_3">
gap> GraphvizAddNode(terminals, "LR_4");
<graphviz node "LR_4">
gap> GraphvizAddNode(terminals, "LR_8");
<graphviz node "LR_8">

#
gap> nodes := GraphvizAddContext(f, "nodes");
<graphviz context "nodes" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(nodes, rec(node := rec(shape := "circle")));
<graphviz context "nodes" with 0 nodes and 0 edges>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_2"), "label", "\"SS(B)\"");
<graphviz edge (LR_0, LR_2)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_1"), "label", "\"SS(S)\"");
<graphviz edge (LR_0, LR_1)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_1", "LR_3"), "label", "\"S($end)\"");
<graphviz edge (LR_1, LR_3)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_6"), "label", "\"SS(b)\"");
<graphviz edge (LR_2, LR_6)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_5"), "label", "\"SS(a)\"");
<graphviz edge (LR_2, LR_5)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_4"), "label", "\"S(A)\"");
<graphviz edge (LR_2, LR_4)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_7"), "label", "\"S(b)\"");
<graphviz edge (LR_5, LR_7)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_5"), "label", "\"S(a)\"");
<graphviz edge (LR_5, LR_5)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_6"), "label", "\"S(b)\"");
<graphviz edge (LR_6, LR_6)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_5"), "label", "\"S(a)\"");
<graphviz edge (LR_6, LR_5)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_8"), "label", "\"S(b)\"");
<graphviz edge (LR_7, LR_8)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_5"), "label", "\"S(a)\"");
<graphviz edge (LR_7, LR_5)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_6"), "label", "\"S(b)\"");
<graphviz edge (LR_8, LR_6)>
gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_5"), "label", "\"S(a)\"");
<graphviz edge (LR_8, LR_5)>

#
gap> Print(AsString(f), "\n");
//dot
digraph finite_state_machine {
  graph [rankdir="LR", size="8,5"]
  {
    // context "terminals" 
    node [shape="doublecircle"]
    LR_0
    LR_3
    LR_4
    LR_8
  }
  {
    // context "nodes" 
    node [shape="circle"]
    LR_2
    LR_0 -> LR_2 [label="SS(B)"]
    LR_1
    LR_0 -> LR_1 [label="SS(S)"]
    LR_1 -> LR_3 [label="S($end)"]
    LR_6
    LR_2 -> LR_6 [label="SS(b)"]
    LR_5
    LR_2 -> LR_5 [label="SS(a)"]
    LR_2 -> LR_4 [label="S(A)"]
    LR_7
    LR_5 -> LR_7 [label="S(b)"]
    LR_5 -> LR_5 [label="S(a)"]
    LR_6 -> LR_6 [label="S(b)"]
    LR_6 -> LR_5 [label="S(a)"]
    LR_7 -> LR_8 [label="S(b)"]
    LR_7 -> LR_5 [label="S(a)"]
    LR_8 -> LR_6 [label="S(b)"]
    LR_8 -> LR_5 [label="S(a)"]
  }
}

#
gap> STOP_TEST("graphviz package: examples/fsm.tst");

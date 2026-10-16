#############################################################################
##
##  rank_same.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://stackoverflow.com/questions/25734244


#@local g, s1, s2
gap> START_TEST("graphviz package: examples/rank_same.tst");
gap> LoadPackage("GraphvizForGAP");
true

#
gap> g := GraphvizDigraph();
<graphviz digraph with 0 nodes and 0 edges>

#
gap> s1 := GraphvizAddSubgraph(g);
<graphviz digraph "no_name_1" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(s1, rec(rank := "same"));
<graphviz digraph "no_name_1" with 0 nodes and 0 edges>
gap> GraphvizAddNode(s1, "A");
<graphviz node "A">
gap> GraphvizAddNode(s1, "X");
<graphviz node "X">

#
gap> GraphvizAddNode(g, "C");
<graphviz node "C">

#
gap> s2 := GraphvizAddSubgraph(g);
<graphviz digraph "no_name_3" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(s2, rec(rank := "same"));
<graphviz digraph "no_name_3" with 0 nodes and 0 edges>
gap> GraphvizAddNode(s2, "B");
<graphviz node "B">
gap> GraphvizAddNode(s2, "D");
<graphviz node "D">
gap> GraphvizAddNode(s2, "Y");
<graphviz node "Y">

#
gap> GraphvizAddEdge(g, "A", "B");
<graphviz edge (A, B)>
gap> GraphvizAddEdge(g, "A", "C");
<graphviz edge (A, C)>
gap> GraphvizAddEdge(g, "C", "D");
<graphviz edge (C, D)>
gap> GraphvizAddEdge(g, "X", "Y");
<graphviz edge (X, Y)>

#
gap> Print(AsString(g), "\n");
//dot
digraph  {
  subgraph no_name_1 {
    graph [rank="same"]
    A
    X
  }
  C
  subgraph no_name_3 {
    graph [rank="same"]
    B
    D
    Y
  }
  A -> B
  A -> C
  C -> D
  X -> Y
}

#
gap> STOP_TEST("graphviz package: examples/rank_same.tst");

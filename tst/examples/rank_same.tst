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
gap> LoadPackage("graphviz");
true

#
gap> g := GraphvizDigraph();
<graphviz digraph with 0 nodes and 0 edges>

#
gap> s1 := GraphvizAddSubgraph(g);
<graphviz digraph no_name_1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(s1, "rank=same");
<graphviz digraph no_name_1 with 0 nodes and 0 edges>
gap> GraphvizAddNode(s1, "A");
<graphviz node A>
gap> GraphvizAddNode(s1, "X");
<graphviz node X>

#
gap> GraphvizAddNode(g, "C");
<graphviz node C>

#
gap> s2 := GraphvizAddSubgraph(g);
<graphviz digraph no_name_3 with 3 nodes and 0 edges>
gap> GraphvizSetAttr(s2, "rank=same");
<graphviz digraph no_name_3 with 3 nodes and 0 edges>
gap> GraphvizAddNode(s2, "B");
<graphviz node B>
gap> GraphvizAddNode(s2, "D");
<graphviz node D>
gap> GraphvizAddNode(s2, "Y");
<graphviz node Y>

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
gap> AsString(g);
"//dot\ndigraph  {\nsubgraph no_name_1 {\n\trank=same \n\tA\n\tX\n}\n\tC\nsubg\
raph no_name_3 {\n\trank=same \n\tB\n\tD\n\tY\n}\n\tA -> B\n\tA -> C\n\tC -> D\
\n\tX -> Y\n}\n"

#
gap> STOP_TEST("graphviz package: rank_same.tst");

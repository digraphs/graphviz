#############################################################################
##
##  rank_same.g
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://stackoverflow.com/questions/25734244

LoadPackage("graphviz");
g := GraphvizDigraph();

s1 := GraphvizAddSubgraph(g);
GraphvizSetAttr(s1, "rank=same");
GraphvizAddNode(s1, "A");
GraphvizAddNode(s1, "X");

GraphvizAddNode(g, "C");

s2 := GraphvizAddSubgraph(g);
GraphvizSetAttr(s2, "rank=same");
GraphvizAddNode(s2, "B");
GraphvizAddNode(s2, "D");
GraphvizAddNode(s2, "Y");

GraphvizAddEdge(g, "A", "B");
GraphvizAddEdge(g, "A", "C");
GraphvizAddEdge(g, "C", "D");
GraphvizAddEdge(g, "X", "Y");

Print(AsString(g));
Splash(g);
QUIT;

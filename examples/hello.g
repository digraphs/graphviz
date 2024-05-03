#############################################################################
##
##  hello.g
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
LoadPackage("graphviz");
graph := GraphvizDigraph("G");
GraphvizAddEdge(graph, "hello", "world");
Print(AsString(graph));
Splash(graph);
QUIT;
